Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291845AbSBAQsz>; Fri, 1 Feb 2002 11:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291846AbSBAQsp>; Fri, 1 Feb 2002 11:48:45 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:23235 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S291845AbSBAQsc>; Fri, 1 Feb 2002 11:48:32 -0500
Date: Fri, 1 Feb 2002 17:48:13 +0100
From: "Axel H. Siebenwirth" <axel@hh59.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.3 - (IDE) hda: drive not ready for command errors
Message-ID: <20020201164813.GA14296@neon>
In-Reply-To: <20020201153303.A1508@prester.hh59.org> <5.1.0.14.2.20020201160018.026603b0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020201160018.026603b0@pop.cus.cam.ac.uk>
User-Agent: Mutt/1.3.27i
Organization: hh59.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton!

On Fri, 01 Feb 2002, Anton Altaparmakov wrote:

> I was about to send the drive (IBM 7200rpm 41GiB) back for replacement when 
> I as last resort tried to upgrade the firmware of the drive.
> 
> After the upgrade the drive started working again, fully passed the Drive 
> Fitness Test (IBM utility) and it has been working for a few weeks non-stop 
> in my file server RAID-1 array since then.

The thing is that they come up now, just since I installed 2.5.3. Might
there be a hope that it is a kernel-related issue (new IDE driver...). Drive
has been working fine ever since till now.

Best regards,
Axel Siebenwirth


P.S.: Would like to write to my WinXP NTFS Partition, is there some hope MS
will ever give out exact specs (they don't, do they?) to have write 
funtionality properly implemented? Is there some other way to contribute?
