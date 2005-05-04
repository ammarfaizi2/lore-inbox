Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261932AbVECX6E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261932AbVECX6E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 19:58:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVECX6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 19:58:04 -0400
Received: from mail.tyan.com ([66.122.195.4]:778 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261932AbVECX6A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 19:58:00 -0400
Message-ID: <3174569B9743D511922F00A0C943142309B07D82@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: RE: x86-64 dual core mapping
Date: Tue, 3 May 2005 17:18:15 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

Did you try "acpi=off" on you test?

YH 

> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de] 
> Sent: Tuesday, May 03, 2005 7:25 AM
> To: YhLu
> Cc: Andi Kleen; linux-kernel@vger.kernel.org
> Subject: Re: x86-64 dual core mapping
> 
> On Mon, May 02, 2005 at 02:01:00PM -0700, YhLu wrote:
> > Andi,
> > 
> > resent. FYI
> 
> I retested with my tree and everything works for me as expected.
> Well actually there is a problem with the core mappings, but 
> not on dual core, but on single core (more cosmetic than real)
> 
> It is possible that some patch is missing again in mainline.
> I will sync up my patchkit next week and double check then 
> that mainline is in the same state as mine.
> 
> -Andi
> 
