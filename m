Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWG1F4S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWG1F4S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 01:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751975AbWG1F4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 01:56:18 -0400
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:27313 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751832AbWG1F4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 01:56:17 -0400
Date: Fri, 28 Jul 2006 01:56:14 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Ingo Molnar <mingo@elte.hu>
cc: Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch] ipc/msg.c: clean up coding style
In-Reply-To: <20060727162434.GA29489@elte.hu>
Message-ID: <Pine.LNX.4.64.0607280153490.13981@d.namei>
References: <20060727135321.GA24644@elte.hu> <20060727144659.GC6825@martell.zuzino.mipt.ru>
 <20060727162434.GA29489@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006, Ingo Molnar wrote:

> > Let's not go BSD way.
> 
> again, lets not have overlong line 80 prototypes.

I thought Linus gave his blessing for long lines for prototypes (up to 120 
chars?), to make it easier to grep the code for function prototypes.


- James
-- 
James Morris
<jmorris@namei.org>
