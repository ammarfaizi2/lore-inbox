Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965130AbVLVIR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965130AbVLVIR4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 03:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbVLVIR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 03:17:56 -0500
Received: from mail1.kontent.de ([81.88.34.36]:22732 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S965127AbVLVIRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 03:17:55 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: ETA for Areca RAID driver (arcmsr) in mainline?
Date: Thu, 22 Dec 2005 09:17:41 +0100
User-Agent: KMail/1.8
Cc: Dax Kelson <dax@gurulabs.com>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
References: <1135228831.4122.15.camel@mentorng.gurulabs.com> <1135229681.439.23.camel@mindpipe>
In-Reply-To: <1135229681.439.23.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512220917.41494.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 22. Dezember 2005 06:34 schrieb Lee Revell:
> On Wed, 2005-12-21 at 22:20 -0700, Dax Kelson wrote:
> > I just got a shiny new (for me at least, the card has been out for
> > months) Areca RAID card.
> > 
> > The driver (arcmsr) is in the -mm kernel, but hasn't yet made it to the
> > mainline kernel. I'm curious what remains to be done before this can
> > happen?
> 
> Well, often all that's needed are some user reports that the driver
> works for them.

Is that a reasonable strategy? Why is a _new_ driver present only in -mm?
It hardly can break anything. It is possible that Andrew is quicker merging
but still I can't see the advantage if this persists for any length of time.

	Regards
		Oliver
