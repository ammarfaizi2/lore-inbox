Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129055AbRBDKQg>; Sun, 4 Feb 2001 05:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129113AbRBDKQ1>; Sun, 4 Feb 2001 05:16:27 -0500
Received: from chambertin.convergence.de ([212.84.236.2]:31245 "EHLO
	chambertin.convergence.de") by vger.kernel.org with ESMTP
	id <S129055AbRBDKQT>; Sun, 4 Feb 2001 05:16:19 -0500
Date: Sun, 4 Feb 2001 11:16:16 +0100 (CET)
From: "Joachim 'roh' Steiger" <roh@convergence.de>
To: Marko Kreen <marko@l-t.ee>
cc: patrick.mourlhon@wanadoo.fr, linux-kernel@vger.kernel.org
Subject: Re: ATAPI CDRW which doesn't work
In-Reply-To: <20010204030644.A23913@l-t.ee>
Message-ID: <Pine.LNX.4.21.0102041112120.20715-100000@campari.convergence.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Feb 2001, Marko Kreen wrote:

> On Sat, Feb 03, 2001 at 11:05:44PM +0100, patrick.mourlhon@wanadoo.fr wrote:
> Compile in options 'SCSI generic', 'SCSI cdrom and 'SCSI
> emulation support' then add 'hdb=scsi' to kernel parameters.
is there someone working on direct support for Atapi-cdrw this time?
i would like to use a clean solution and am ready to help testing such
stuff (if existing) with my yamaha atapi-cdrw connected to an asus a7v

regards

roh

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
