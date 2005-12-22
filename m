Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965126AbVLVIUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965126AbVLVIUI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 03:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbVLVIUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 03:20:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64456 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965126AbVLVIUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 03:20:06 -0500
Subject: Re: ETA for Areca RAID driver (arcmsr) in mainline?
From: Arjan van de Ven <arjan@infradead.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Lee Revell <rlrevell@joe-job.com>, Dax Kelson <dax@gurulabs.com>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
In-Reply-To: <200512220917.41494.oliver@neukum.org>
References: <1135228831.4122.15.camel@mentorng.gurulabs.com>
	 <1135229681.439.23.camel@mindpipe>  <200512220917.41494.oliver@neukum.org>
Content-Type: text/plain
Date: Thu, 22 Dec 2005 09:20:00 +0100
Message-Id: <1135239601.2940.5.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.8 (--)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (-2.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-12-22 at 09:17 +0100, Oliver Neukum wrote:
> Am Donnerstag, 22. Dezember 2005 06:34 schrieb Lee Revell:
> > On Wed, 2005-12-21 at 22:20 -0700, Dax Kelson wrote:
> > > I just got a shiny new (for me at least, the card has been out for
> > > months) Areca RAID card.
> > > 
> > > The driver (arcmsr) is in the -mm kernel, but hasn't yet made it to the
> > > mainline kernel. I'm curious what remains to be done before this can
> > > happen?
> > 
> > Well, often all that's needed are some user reports that the driver
> > works for them.
> 
> Is that a reasonable strategy? Why is a _new_ driver present only in -mm?
> It hardly can break anything. It is possible that Andrew is quicker merging
> but still I can't see the advantage if this persists for any length of time.

afaik that's not the strategy here.
It's more "we're waiting for the structural issues to be resolved" which
sounds quite reasonable.


