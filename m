Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261860AbVCYXlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261860AbVCYXlY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 18:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbVCYXlX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 18:41:23 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:47143 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261860AbVCYXlQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 18:41:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Af1vCH/AXpf0yxURYOXVLFGRcDZoReR3DG7qUqVcl7Jq6HSX+kebK6kGSxDeHNCyI5Z672ebHj+nbX3xJ4rWye+stkOWPHgnnntyK0vOUi7G5+6iY74y645BylbogV+GuQF9U4DFv+uEnosOWFr8+nb/7hHH//lbEgP+rTUD+jk=
Message-ID: <2a0fbc5905032515414ce6ac87@mail.gmail.com>
Date: Sat, 26 Mar 2005 00:41:15 +0100
From: Julien Wajsberg <julien.wajsberg@gmail.com>
Reply-To: Julien Wajsberg <julien.wajsberg@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: How's the nforce4 support in Linux?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1111792902.23430.34.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <2a0fbc59050325145935a05521@mail.gmail.com>
	 <1111792902.23430.34.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Mar 2005 18:21:42 -0500, Lee Revell <rlrevell@joe-job.com> wrote:
> On Fri, 2005-03-25 at 23:59 +0100, Julien Wajsberg wrote:
> > Mar 25 22:42:55 evenflow kernel: hda: dma_timer_expiry: dma status == 0x60
> > Mar 25 22:42:55 evenflow kernel: hda: DMA timeout retry
> > Mar 25 22:42:55 evenflow kernel: hda: timeout waiting for DMA
> > Mar 25 22:42:55 evenflow kernel: hda: status error: status=0x58 {
> > DriveReady SeekComplete DataRequest }
> > Mar 25 22:42:55 evenflow kernel:
> > Mar 25 22:42:55 evenflow kernel: ide: failed opcode was: unknown
> > Mar 25 22:42:55 evenflow kernel: hda: drive not ready for command
> > Mar 25 22:42:55 evenflow kernel: hda: status timeout: status=0xd0 { Busy }
> > Mar 25 22:42:55 evenflow kernel:
> > Mar 25 22:42:55 evenflow kernel: ide: failed opcode was: unknown
> > Mar 25 22:42:55 evenflow kernel: hdb: DMA disabled
> > Mar 25 22:42:55 evenflow kernel: hda: drive not ready for command
> 
> Are you sure the drive is OK?  Those messages are the classic signs of a
> failing drive...

It's nearly new, and it was ok in my last computer (an old P3-500 with
PIIX4, IIRC).
BTW I did a complete badblocks check on it, and it found nothing.

-- 
Julien
