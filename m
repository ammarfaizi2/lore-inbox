Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313445AbSC2N43>; Fri, 29 Mar 2002 08:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313444AbSC2N4Y>; Fri, 29 Mar 2002 08:56:24 -0500
Received: from virgo.cus.cam.ac.uk ([131.111.8.20]:45699 "EHLO
	virgo.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S313443AbSC2N4M>; Fri, 29 Mar 2002 08:56:12 -0500
Date: Fri, 29 Mar 2002 13:56:11 +0000 (GMT)
From: Anton Altaparmakov <aia21@cus.cam.ac.uk>
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
cc: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
	<linux-ntfs-dev@lists.sourceforge.net>,
        Padraig Brady <padraig@antefacto.com>
Subject: Re: Re[2]: ANN: NTFS 2.0.1 for kernel 2.5.7 released
In-Reply-To: <ISPFE11z1aiG4HHZM9I000037fa@mail.takas.lt>
Message-ID: <Pine.SOL.3.96.1020329134328.18653B-100000@virgo.cus.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002, Nerijus Baliunas wrote:
> On Fri, 29 Mar 2002 12:57:07 +0000 (GMT) Anton Altaparmakov <aia21@cus.cam.ac.uk> wrote:
> AA> > To have all files executable breaks stuff like:
> AA> > midnight commander (won't open executable files)
> AA> 
> AA> Ouch, that is plain stupid... mc should be fixed. I open executables all
> AA> the time and mc should automatically fire up a hexeditor.
> 
> You probably misunderstood the problem - I cannot enter archive files (.tgz, .zip)
> in mc if these files are marked as executable - mc just tries to execute them.

Ah, that is a bad thing. (I don't use mc as you may have guessed...)

> AA> I guess if more people complain I can change the default fmask to be 0177
> AA> instead of 0077 but I want to see more complaints first. I personally find
> AA> the being able to execute behaviour better as I run things off the ntfs
> AA> partitions...
> 
> People using Linux usually keep data files on fat and ntfs permissions, not
> executables (IMHO).

Depends what you are doing and whether you use wine or not... I have no
idea what the percentages are...

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

