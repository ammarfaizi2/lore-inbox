Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUKWXPM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUKWXPM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 18:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261623AbUKWXMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 18:12:47 -0500
Received: from rrcs-24-227-247-8.sw.biz.rr.com ([24.227.247.8]:28369 "EHLO
	emachine.austin.ammasso.com") by vger.kernel.org with ESMTP
	id S261617AbUKWXLf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 18:11:35 -0500
Message-ID: <41A3C31E.5060007@ammasso.com>
Date: Tue, 23 Nov 2004 17:09:18 -0600
From: Timur Tabi <timur.tabi@ammasso.com>
Organization: Ammasso
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove pointless <0 comparison for unsigned variable
 in fs/fcntl.c
References: <Pine.LNX.4.61.0411212351210.3423@dragon.hygekrogen.localhost> <20041122010253.GE25636@parcelfarce.linux.theplanet.co.uk> <41A30612.2040700@dif.dk> <Pine.LNX.4.58.0411230958260.20993@ppc970.osdl.org> <41A38BF1.9060207@ammasso.com> <Pine.LNX.4.61.0411240003300.3389@dragon.hygekrogen.localhost> <41A3C1AE.5060604@ammasso.com> <Pine.LNX.4.61.0411240016350.3389@dragon.hygekrogen.localhost>
In-Reply-To: <Pine.LNX.4.61.0411240016350.3389@dragon.hygekrogen.localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

> My understanding of it is that it was just an example of how code that 
> generated warnings about limited range of datatype could actually be 
> perfectly fine.

But if the example doesn't make any sense, then how does it prove the point?

-- 
Timur Tabi
Staff Software Engineer
timur.tabi@ammasso.com
