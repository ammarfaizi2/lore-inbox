Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290272AbSAOUQa>; Tue, 15 Jan 2002 15:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290273AbSAOUQV>; Tue, 15 Jan 2002 15:16:21 -0500
Received: from libra.cus.cam.ac.uk ([131.111.8.19]:21662 "EHLO
	libra.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S290272AbSAOUQP>; Tue, 15 Jan 2002 15:16:15 -0500
Date: Tue, 15 Jan 2002 20:16:13 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: "Eric S. Raymond" <esr@thyrsus.com>
cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2-2.1.3 is available
In-Reply-To: <20020115145324.A5772@thyrsus.com>
Message-ID: <Pine.SOL.3.96.1020115201156.26402C-100000@libra.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002, Eric S. Raymond wrote:

> The latest version is always available at <http://www.tuxedo.org/~esr/cml2/>.
> 
> Release 2.1.3: Tue Jan 15 14:41:45 EST 2002
> 	* Resync with 2.4.18-pre3 and 2.5.2.
> 	* It is now possible to declare explicit saveability predicates.
> 	* The `vitality' flag is gone from the language.  Instead, the 
> 	  autoprober detects the type of your root filesystem and forces
> 	  its symbol to Y.
> 
> The interactive configurators remain stable; no bugs of any kind have been 
> reported since 6 Jan.  I'm waiting on an update of the probe tables from
> Giacomo Catenazzi before releasing 2.2.0.

</me ignorant of current state of cml2>I sometimes configure and compile
kernels for different computers on my athlon due to the extremely fast
compile time on the athlon. The autoprober would interfere here extremely
badly. Is it disabled by default? I.e. if I do make menuconfig or make
oldconfig will the autoprober temper with my choices?

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

