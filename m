Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310916AbSC2SKH>; Fri, 29 Mar 2002 13:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311593AbSC2SJ5>; Fri, 29 Mar 2002 13:09:57 -0500
Received: from tomts6.bellnexxia.net ([209.226.175.26]:9449 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S310916AbSC2SJt>; Fri, 29 Mar 2002 13:09:49 -0500
Date: Fri, 29 Mar 2002 13:09:46 -0500
From: Grogan <2grogan@sympatico.ca>
To: linux-kernel@vger.kernel.org
Subject: Re: ANN: NTFS 2.0.1 for kernel 2.5.7 released
Message-Id: <20020329130946.4672c423.2grogan@sympatico.ca>
In-Reply-To: <5.1.0.14.2.20020328200457.03dfda90@pop.cus.cam.ac.uk>
Organization: PC911
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Mar 2002 20:08:30 +0000
Anton Altaparmakov <aia21@cam.ac.uk> wrote:

> Hi,
> 
> NTFS 2.0.1 for kernel 2.5.7 is now available. This is a minor update, 
> mainly to allow binaries to be executed by changing the default permissions 
> on files to include the executable bit. This feature has often been 
> requested by wine users so here it is. (-:

I thought that was a pretty good change,  making the default permissions executable. After all, that's how FAT filesystems are mounted by default. I often wondered about that, -r-------- for regular files on the mounted NTFS volume.

I'm not at all interested in WINE (no desire to run Windows programs in Linux, I love the software I have) but I do sometimes store things on microsoft partitions and it's useful to be able to run an install script in place rather than copying the files and setting +x (e.g. Star Office installer .bin files)

By the way, I did try this new driver yesterday and did not experience any problems with it. I'm using this kernel right now.  Behaviour as expected. I don't know what version of mc they are talking about, but in my version of mc ("The Midnight Commander 4.5.51") I can use the view command on any file on the NTFS partition without it trying to execute the file. The files are all showing in green, with the asterisk.

Grogan
