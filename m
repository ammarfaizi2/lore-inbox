Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129172AbRBVLyT>; Thu, 22 Feb 2001 06:54:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129185AbRBVLyI>; Thu, 22 Feb 2001 06:54:08 -0500
Received: from ns.caldera.de ([212.34.180.1]:41224 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129172AbRBVLxv>;
	Thu, 22 Feb 2001 06:53:51 -0500
Date: Thu, 22 Feb 2001 12:53:15 +0100
From: Christoph Hellwig <hch@caldera.de>
To: Peter Samuelson <peter@cadcamlab.org>
Cc: lvm-devel@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [lvm-devel] *** ANNOUNCEMENT *** LVM 0.9.1 beta5 available at www.sistina.com
Message-ID: <20010222125315.A17011@caldera.de>
Mail-Followup-To: Peter Samuelson <peter@cadcamlab.org>,
	lvm-devel@sistina.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010221180035.N25927@athlon.random> <200102211718.SAA25997@ns.caldera.de> <20010221221225.B21010@cadcamlab.org> <20010222104603.A1992@caldera.de> <14996.61315.647325.114938@wire.cadcamlab.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <14996.61315.647325.114938@wire.cadcamlab.org>; from peter@cadcamlab.org on Thu, Feb 22, 2001 at 04:52:51AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 04:52:51AM -0600, Peter Samuelson wrote:
> 
>   [Peter Samuelson]
> > > How often do you run MAKEDEV or vgscan?
> 
> [Christoph Hellwig]
> > On every bootup, _before_ doing mount -a
> 
> A mere 'vgchange -ay' works fine for *my* boot processes.  Is there a
> particular reason to do 'vgscan' every time?  (I'm not arguing -- just
> wondering.)

It is that what is suggested by the LVM crew.  I have also tried to use
it without vgscan - it work then and whenn, but not 100% percent reliable.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
Whip me.  Beat me.  Make me maintain AIX.
