Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316576AbSGGTts>; Sun, 7 Jul 2002 15:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316577AbSGGTtr>; Sun, 7 Jul 2002 15:49:47 -0400
Received: from cmailg7.svr.pol.co.uk ([195.92.195.177]:47722 "EHLO
	cmailg7.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S316576AbSGGTtq>; Sun, 7 Jul 2002 15:49:46 -0400
Date: Sun, 7 Jul 2002 21:51:51 +0100
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-lvm@sistina.com, linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] LVM2 modifies the buffer_head struct?
Message-ID: <20020707205151.GC2400@fib011235813.fsnet.co.uk>
References: <F19741gcljD2E2044cY00004523@hotmail.com> <20020702141702.GA9769@fib011235813.fsnet.co.uk> <20020703100838.GH14097@suse.de> <20020703120124.GB615@fib011235813.fsnet.co.uk> <20020703121024.GC21568@suse.de> <15651.54044.557070.109158@notabene.cse.unsw.edu.au> <20020704075830.GQ21568@suse.de> <3D2409FA.44E88C1D@zip.com.au> <20020704083941.GA6204@suse.de> <3D2418FE.FEA0B9E9@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D2418FE.FEA0B9E9@zip.com.au>
User-Agent: Mutt/1.3.28i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

On Thu, Jul 04, 2002 at 02:44:30AM -0700, Andrew Morton wrote:
> Here it is.  We can slot this into 2.4.20-pre, or Joe can own
> it.  Any preferences?

Thanks for doing this, I'll keep this with the device-mapper patches
for now.

- Joe
