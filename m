Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313130AbSDYP0u>; Thu, 25 Apr 2002 11:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313137AbSDYP0t>; Thu, 25 Apr 2002 11:26:49 -0400
Received: from arsenal.visi.net ([206.246.194.60]:35274 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S313130AbSDYP0s>;
	Thu, 25 Apr 2002 11:26:48 -0400
Date: Thu, 25 Apr 2002 11:23:28 -0400
From: Ben Collins <bcollins@debian.org>
To: FonkiE <fonkie@fsmat.at>
Cc: linux1394-user@lists.sourceforge.net,
        linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: problems with sbp2 and sd_mod (ipod firewire harddisk)
Message-ID: <20020425152328.GD508@blimpo.internal.net>
In-Reply-To: <3CC81A29.3050204@fsmat.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2002 at 05:00:57PM +0200, FonkiE wrote:
> hi!
> 
> i have an ipod too. yesterday everything worked fine. today i updated
> from firmware 1.02 to 1.1. now the system crashed with 'modprobe sbp2'.

See our website for obtaining the latest source. There are a lot of
changes to ohci1394 and sbp2 that have so far fixed every known issue
with sbp2 devices.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://linux1394.sourceforge.net/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
