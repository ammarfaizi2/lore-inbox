Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265005AbSKAM6W>; Fri, 1 Nov 2002 07:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265002AbSKAM6W>; Fri, 1 Nov 2002 07:58:22 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:51725 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S265005AbSKAM5s>; Fri, 1 Nov 2002 07:57:48 -0500
Date: Fri, 1 Nov 2002 08:03:55 -0500
From: Ben Collins <bcollins@debian.org>
To: Nikita Shulga <malfet@mipt.sw.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ISOFS question
Message-ID: <20021101130355.GI1521@phunnypharm.org>
References: <200211020546.10758.malfet@mipt.sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211020546.10758.malfet@mipt.sw.ru>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 02, 2002 at 05:46:10AM -0800, Nikita Shulga wrote:
> Hi!
> Is it planned(or already impleneted) to support CD with (blocksize != 2^n)? 
> As far as I know this is the main problem why I can't simply mount VCD? 
> Thanks in advance,
> 	Nikita
> P.S. I'm not a member of list, so plz, CC your answer to me

Errm, if I know my formats (which I might not) you can't mount a VCD
because it is just mpeg written to a track, not ISOFS or any sort of FS
at all.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
