Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279604AbRJXVUQ>; Wed, 24 Oct 2001 17:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279617AbRJXVUG>; Wed, 24 Oct 2001 17:20:06 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:7666
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S279604AbRJXVTt>; Wed, 24 Oct 2001 17:19:49 -0400
Date: Wed, 24 Oct 2001 14:20:18 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ken Moffat <ken@kenmoffat.uklinux.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Depmod errors with fs modules, 2.4.12-ac3
Message-ID: <20011024142018.A22668@mikef-linux.matchmail.com>
Mail-Followup-To: Ken Moffat <ken@kenmoffat.uklinux.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0110242208500.783-200000@pppg_penguin.linux.bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0110242208500.783-200000@pppg_penguin.linux.bogus>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2001 at 10:11:10PM +0100, Ken Moffat wrote:
> I got the attached errors (in lockd.o, nfs.o, nfsd.o) tonight. Kernel is
> 2.4.12-ac3 with the preemptive patch.
> 

Strange, I've used that kernel with nfs modules without problems.  Do you
have nfsV3 enabled?

What about compiler version, and .config?
