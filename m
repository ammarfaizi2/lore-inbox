Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964909AbWBQNiA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964909AbWBQNiA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 08:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbWBQNh7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 08:37:59 -0500
Received: from bayc1-pasmtp10.bayc1.hotmail.com ([65.54.191.170]:4382 "EHLO
	BAYC1-PASMTP10.BAYC1.HOTMAIL.COM") by vger.kernel.org with ESMTP
	id S964909AbWBQNh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 08:37:58 -0500
Message-ID: <BAYC1-PASMTP1013B46C27CAE01CF78F54AEF80@CEZ.ICE>
X-Originating-IP: [65.94.251.146]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Fri, 17 Feb 2006 08:37:10 -0500
From: sean <seanlkml@sympatico.ca>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: schilling@fokus.fraunhofer.de, dhazelton@enter.net, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-Id: <20060217083710.2dc6879e.seanlkml@sympatico.ca>
In-Reply-To: <43F5B686.nail2VCA2A2OF@burner>
References: <43EB7BBA.nailIFG412CGY@burner>
	<20060216115204.GA8713@merlin.emma.line.org>
	<43F4BF26.nail2KA210T4X@burner>
	<200602161742.26419.dhazelton@enter.net>
	<43F5B686.nail2VCA2A2OF@burner>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.12; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Feb 2006 13:38:57.0937 (UTC) FILETIME=[80D1A810:01C633C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Feb 2006 12:41:58 +0100
Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:

> In 1997, I did cleanly write dowen what exact features are missing to allow 
> Linux to be used to _develop_ SCSI user space programs. I did even send a patch
> for sg.c to the Linux folks. This patch extends the sg SCSI Generic interface
> in a source AND binary, up AND downwards compatible way.
> 
> This patch has been rejected for unknown reasons and the fact that the source 
> code fond in official Linux release has been changed in an incompatible way, it 
> is impossible to apply it now.

Shock!  1997 patch no longer applies cleanly in 2006!  Alert the media!

Seriously though, this is exactly why I think Linux should start accepting
patches from crazy people without question or review.   It's much easier to
deal with whatever cruft is applied by the patch than it is to endure the 
multi year manic tirades of such individuals who have their egos bruised as
a result of rejection.

Sean
