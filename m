Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263066AbREaPCT>; Thu, 31 May 2001 11:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263104AbREaPCJ>; Thu, 31 May 2001 11:02:09 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:6473 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S263102AbREaPCD>; Thu, 31 May 2001 11:02:03 -0400
Date: Thu, 31 May 2001 17:00:48 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>
Cc: hajek@idoox.com, linux-kernel@vger.kernel.org
Subject: Re: 2.2.19 and LFS patch?
Message-ID: <20010531170048.A24185@athlon.random>
In-Reply-To: <20010530235416.A2908@pida.ulita.cz> <20010531095100.E19379@pc8.lineo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010531095100.E19379@pc8.lineo.fr>; from christophe.barbe@lineo.fr on Thu, May 31, 2001 at 09:51:00AM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2001 at 09:51:00AM +0200, christophe barbé wrote:
> Sistina (www.sistina.com) provides one in its last GFS release (v4.1). This
> pach IIRC is based on the SUSE one.

yes. You can always find the latest and greatest LFS in my 2.2 tree (I
also accept patches regularly for it):

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.2/2.2.20pre2aa1/40_lfs-2.2.19pre16aa1-26.bz2

It is not against vanilla 2.2.19 or vanilla 2.2.20pre2 so you need to
apply a few other patches in my tree first or to fix the few rejects by
hand, but if you need lfs you probably need the other features as well,
so you can more simply use the whole 2.2.20pre2aa1 patchkit.

Andrea
