Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbTCKISu>; Tue, 11 Mar 2003 03:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262862AbTCKISt>; Tue, 11 Mar 2003 03:18:49 -0500
Received: from [196.41.29.142] ([196.41.29.142]:11760 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id <S262859AbTCKISr>; Tue, 11 Mar 2003 03:18:47 -0500
Subject: Re: Corruption problem with ext3 and htree
From: Martin Schlemmer <azarah@gentoo.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger@clusterfs.com>, KML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030311061911.GF1965@think.thunk.org>
References: <20030307063940.6d81780e.azarah@gentoo.org>
	 <20030306234819.Q1373@schatzie.adilger.int>
	 <20030309063345.47046254.azarah@gentoo.org>
	 <20030311061911.GF1965@think.thunk.org>
Content-Type: text/plain
Organization: 
Message-Id: <1047371228.3512.46.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2- 
Date: 11 Mar 2003 10:27:08 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-11 at 08:19, Theodore Ts'o wrote:
> Hmm... can you help construct a test case that doesn't rely on the
> presence of the Gentoo distribution?  Is there some way we can
> instrument the python code so we can see the exact filesystem
> operations (renames, deletions, moves, etc.) that is going on?  The
> good news is that you say that you're able to reproduce it every
> single time, which implies it's not a timing related problem.
> 

Ok, will try to get A short way to duplicate this.


Regards,

-- 
Martin Schlemmer


