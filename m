Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264499AbUEaBcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264499AbUEaBcE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 21:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUEaBcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 21:32:04 -0400
Received: from mtvcafw.SGI.COM ([192.48.171.6]:48762 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264499AbUEaBcB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 21:32:01 -0400
Date: Mon, 31 May 2004 11:31:41 +1000
From: Tim Shimmin <tes@sgi.com>
To: Ricky Beam <jfbeam@bluetronic.net>
Cc: Steve Lord <lord@xfs.org>,
       Linux Kernel Mail List <linux-kernel@vger.kernel.org>,
       XFS List <linux-xfs@oss.sgi.com>
Subject: Re: xfs partition refuses to mount
Message-ID: <20040531113141.A1116544@boing.melbourne.sgi.com>
References: <40B8D24A.4080703@xfs.org> <Pine.GSO.4.33.0405291528450.14297-100000@sweetums.bluetronic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.4.33.0405291528450.14297-100000@sweetums.bluetronic.net>; from jfbeam@bluetronic.net on Sat, May 29, 2004 at 03:35:34PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricky,

On Sat, May 29, 2004 at 03:35:34PM -0400, Ricky Beam wrote:
> (I've had the journal become spooge on a sparc64 box a few times.)
> 
Until May 20 (just over a week ago) recovery on sparc64 (and big endian
64) did not work. A fix went into xfs_bit.c thanks to Nicolas
Boullis. (Our XFS qa tests are routinely run on intel cpus)

--Tim
