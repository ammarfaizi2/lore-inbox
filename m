Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265360AbUEZIlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265360AbUEZIlP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 04:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265361AbUEZIlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 04:41:15 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:65285 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265360AbUEZIlN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 04:41:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: orders@nodivisions.com, linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Date: Wed, 26 May 2004 11:32:31 +0300
X-Mailer: KMail [version 1.4]
References: <40B43B5F.8070208@nodivisions.com>
In-Reply-To: <40B43B5F.8070208@nodivisions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200405261132.32024.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 May 2004 09:38, Anthony DiSante wrote:
> As a general question about ram/swap and relating to some of the issues in
> this thread:
>
> 	~500 megs cached yet 2.6.5 goes into swap hell
>
> Consider this: I have a desktop system with 256MB ram, so I make a 256MB
> swap partition.  So I have 512MB "memory" and if some process wants more,
> too bad, there is no more.
>
> Now I buy another 256MB of ram, so I have 512MB of real memory.  Why not
> just disable my swap completely now?  I won't have increased my memory's
> size at all, but won't I have increased its performance lots?
>
> Or, to make it more appealing, say I initially had 512MB ram and now I have
> 1GB.  Wouldn't I much rather not use swap at all anymore, in this case, on
> my desktop?

Yes, you can run swapless. Nothing wrong with that.
--
vda
