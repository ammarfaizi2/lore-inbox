Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313562AbSDZAoO>; Thu, 25 Apr 2002 20:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313564AbSDZAoN>; Thu, 25 Apr 2002 20:44:13 -0400
Received: from mailengine01.direcpc.com ([206.71.110.4]:16132 "HELO
	mailengine01.direcpc.com") by vger.kernel.org with SMTP
	id <S313562AbSDZAoN>; Thu, 25 Apr 2002 20:44:13 -0400
Date: Thu, 25 Apr 2002 20:40:38 -0400
From: Ben Collins <bcollins@debian.org>
To: Avi Shevin <avi@avi.ashevin.com>
Cc: linux1394-devel@lists.sourceforge.net
Subject: Re: firewire harddrive access causes system hang
Message-ID: <20020426004038.GA498@blimpo.internal.net>
In-Reply-To: <Pine.LNX.4.21.0204251953110.674-100000@avi.ashevin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2002 at 08:07:12PM -0400, Avi Shevin wrote:
> Hi all,
> 
> I have a Maxtor PCI IEEE1394 controller card with an ACOMData 60GB
> firewire drive attached to it.  I can successfully mount the drive as
> /dev/sda1 after inserting the ieee1394 and scsi modules in the correct
> order.  The problem is that accessing the disk too many times (?)
> causes the machine to hang.  The last time it did this, I was copying
> the kernel source to it, as a test.  It froze in mid screen refresh.

Best place for this is on the linux1394 mailing list.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://linux1394.sourceforge.net/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/

