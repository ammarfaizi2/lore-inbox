Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030527AbWBNJWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030527AbWBNJWN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030530AbWBNJWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:22:13 -0500
Received: from mail.gmx.de ([213.165.64.21]:46045 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030527AbWBNJWL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:22:11 -0500
X-Authenticated: #428038
Date: Tue, 14 Feb 2006 10:22:07 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Nix <nix@esperi.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060214092207.GA32405@merlin.emma.line.org>
Mail-Followup-To: Nix <nix@esperi.org.uk>, linux-kernel@vger.kernel.org
References: <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de> <43D7C1DF.1070606@gmx.de> <878xt3rfjc.fsf@amaterasu.srvr.nix> <43ED005F.5060804@tmr.com> <20060210235654.GA22512@kroah.com> <43F0891E.nailKUSCGC52G@burner> <871wy6sy7y.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871wy6sy7y.fsf@hades.wkstn.nix>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Feb 2006, Nix wrote:

> (I doubt libscg would ever be interested in the stuff in most of the
> other directories: things like /dev/mem are not SCSI devices and never
> will be, and /sys/class/scsi_device contains *everything* Linux
> considers a SCSI device, no matter what transport it is on, SATA and
> all. However, I don't know if it handles IDE devices that you can SG_IO
> to because I don't have any such here. Anyone know?)

My ATAPI DVD and CD writers are not listed in /sys/class/scsi_device.

-- 
Matthias Andree
