Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269340AbRHGOu3>; Tue, 7 Aug 2001 10:50:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269322AbRHGOu0>; Tue, 7 Aug 2001 10:50:26 -0400
Received: from waste.org ([209.173.204.2]:9490 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S270228AbRHGOuF>;
	Tue, 7 Aug 2001 10:50:05 -0400
Date: Tue, 7 Aug 2001 09:49:58 -0500 (CDT)
From: Oliver Xymoron <oxymoron@waste.org>
To: Michael Heinz <mheinz@infiniconsys.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Resources for SCSI, SRP, Infiniband?
In-Reply-To: <3B6EA6FB.5090505@infiniconsys.com>
Message-ID: <Pine.LNX.4.30.0108070943550.24455-100000@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Aug 2001, Michael Heinz wrote:

> I'm tasked with developing a new SCSI driver for 2.4; but I'm running
> into issues that (a) SCSI drivers are different from other Linux device
> drivers and (b) none of the SCSI driver docs/how-tos seem to have been
> updated since 2.0.x.
>
> I'm making progress, but could someone direct me to a list of do's and
> don't's for SCSI drivers in 2.4?
>
> Also, anybody else looking at developing IB and or SRP?

The mention of all of the above together suggests you're working on iSCSI
or something similar. If so, there are at least three open implementations
for Linux, from Cisco, Intel, and UNH. Are you looking for Secure Remote
Password (speced for iSCSI authentication) or Selective Retransmission
Protocol?

--
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.."

