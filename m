Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313423AbSC2Nac>; Fri, 29 Mar 2002 08:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313438AbSC2NaW>; Fri, 29 Mar 2002 08:30:22 -0500
Received: from mail-src.takas.lt ([212.59.31.66]:52398 "EHLO mail.takas.lt")
	by vger.kernel.org with ESMTP id <S313408AbSC2NaD>;
	Fri, 29 Mar 2002 08:30:03 -0500
Date: Fri, 29 Mar 2002 15:24:12 +0200 (EET)
From: Nerijus Baliunas <nerijus@users.sourceforge.net>
Subject: Re[2]: ANN: NTFS 2.0.1 for kernel 2.5.7 released
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ntfs-dev@lists.sourceforge.net" 
	<linux-ntfs-dev@lists.sourceforge.net>,
        Padraig Brady <padraig@antefacto.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Disposition: INLINE
In-Reply-To: <Pine.SOL.3.96.1020329124320.18653A-100000@virgo.cus.cam.ac.uk>
X-Mailer: Mahogany 0.64.2 'Sparc', compiled for Linux 2.4.18-rc4 i686
Message-ID: <ISPFE11QlZFJyUpZ7Nq000037fb@mail.takas.lt>
X-OriginalArrivalTime: 29 Mar 2002 13:30:02.0245 (UTC) FILETIME=[D486CB50:01C1D725]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002 12:57:07 +0000 (GMT) Anton Altaparmakov <aia21@cus.cam.ac.uk> wrote:

AA> > To have all files executable breaks stuff like:
AA> > midnight commander (won't open executable files)
AA> 
AA> Ouch, that is plain stupid... mc should be fixed. I open executables all
AA> the time and mc should automatically fire up a hexeditor.

You probably misunderstood the problem - I cannot enter archive files (.tgz, .zip)
in mc if these files are marked as executable - mc just tries to execute them.

AA> I guess if more people complain I can change the default fmask to be 0177
AA> instead of 0077 but I want to see more complaints first. I personally find
AA> the being able to execute behaviour better as I run things off the ntfs
AA> partitions...

People using Linux usually keep data files on fat and ntfs permissions, not
executables (IMHO).

Regards,
Nerijus

