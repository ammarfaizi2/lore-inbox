Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291889AbSBARxr>; Fri, 1 Feb 2002 12:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291887AbSBARxj>; Fri, 1 Feb 2002 12:53:39 -0500
Received: from [24.64.71.161] ([24.64.71.161]:21746 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S291889AbSBARxX>;
	Fri, 1 Feb 2002 12:53:23 -0500
Date: Fri, 1 Feb 2002 10:52:34 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: "Axel H. Siebenwirth" <axel@hh59.org>
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.3 - (IDE) hda: drive not ready for command errors
Message-ID: <20020201105234.D763@lynx.adilger.int>
Mail-Followup-To: "Axel H. Siebenwirth" <axel@hh59.org>,
	Anton Altaparmakov <aia21@cam.ac.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020201153303.A1508@prester.hh59.org> <5.1.0.14.2.20020201160018.026603b0@pop.cus.cam.ac.uk> <20020201164813.GA14296@neon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020201164813.GA14296@neon>; from axel@hh59.org on Fri, Feb 01, 2002 at 05:48:13PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 01, 2002  17:48 +0100, Axel H. Siebenwirth wrote:
> P.S.: Would like to write to my WinXP NTFS Partition, is there some hope MS
> will ever give out exact specs (they don't, do they?) to have write 
> funtionality properly implemented? Is there some other way to contribute?

Try out the ntfs-tng driver at sourceforge.net.  It is your best bet.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

