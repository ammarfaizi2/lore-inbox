Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265563AbUEZMhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265563AbUEZMhc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 08:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265553AbUEZMgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 08:36:54 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:60683 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S265529AbUEZMe0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 08:34:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Buddy Lumpkin" <b.lumpkin@comcast.net>
Subject: RE: why swap at all?
Date: Wed, 26 May 2004 15:19:45 +0300
X-Mailer: KMail [version 1.4]
Cc: <orders@nodivisions.com>, <linux-kernel@vger.kernel.org>
References: <S265514AbUEZMDj/20040526120339Z+1733@vger.kernel.org>
In-Reply-To: <S265514AbUEZMDj/20040526120339Z+1733@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200405261519.45746.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 May 2004 15:07, Buddy Lumpkin wrote:
> those environments horizontally in most cases. The biggest performance
> problems to solve (that people care about and are willing to pay $$ to
> solve) are for the large databases that run Corporate America. There are
> certainly scientific applications where performance is critical and there
> are dollars to fund improvement as well, but their numbers don't compare to
> the number of Oracle instances out there running in the Enterprise.

Oh yeah, poor Corporate America. That what we should care most of.

> Optimizing the performance of swap operations for even a small tradeoff in
> performance for memory operations that take place entirely in physical
> memory is just a broke minded, brain dead direction in the year 2004 IMHO.

Sorry Buddy. I am _not_ Corporate America.
I have 4 boxes at work and 5 boxes at home,
and only one of them can be safely run swapless. It's a router.
--
vda
