Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270249AbRHWTnu>; Thu, 23 Aug 2001 15:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270240AbRHWTmx>; Thu, 23 Aug 2001 15:42:53 -0400
Received: from ezri.xs4all.nl ([194.109.253.9]:8651 "HELO ezri.xs4all.nl")
	by vger.kernel.org with SMTP id <S270221AbRHWTmW>;
	Thu, 23 Aug 2001 15:42:22 -0400
Message-ID: <20010823214236.32833@ally.lammerts.org>
Date: Thu, 23 Aug 2001 21:42:36 +0200
From: Eric Lammerts <eric@ally.lammerts.org>
To: Ajit Jena <ajit@cc.iitb.ac.in>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Quantum DLT 4000 issues
In-Reply-To: <Pine.GSO.4.33.0108232119510.12312-100000@indra.cc.iitb.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.79e
In-Reply-To: <Pine.GSO.4.33.0108232119510.12312-100000@indra.cc.iitb.ernet.in>; from Ajit Jena on Thu, Aug 23, 2001 at 09:22:39PM +0530
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, Aug 23, 2001 at 09:22:39PM +0530, Ajit Jena wrote:

> We have a Quantum DLT 4000 1/15 drive connected to an HP9000 system.
> 
> I was wondering if I can connect the same drive to a Linux box having
> wide SCSI interface. Do u think this is a workable proposition ? What
> extra hardware/software I need to procure ? Please advise.

We have a DLT4000 connected to an Adaptec 2940 controller (narrow scsi).
Just turn on SCSI tape support and you're all set.

Eric
