Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264688AbSKDOjX>; Mon, 4 Nov 2002 09:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264689AbSKDOjX>; Mon, 4 Nov 2002 09:39:23 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:61603 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S264688AbSKDOjW>;
	Mon, 4 Nov 2002 09:39:22 -0500
Date: Mon, 4 Nov 2002 14:45:15 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "Theodore Ts'o" <tytso@mit.edu>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: an updated post-halloween doc.
Message-ID: <20021104144515.GA22371@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Theodore Ts'o <tytso@mit.edu>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20021101204832.GA3718@suse.de> <20021104142105.GA9197@think.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021104142105.GA9197@think.thunk.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 09:21:06AM -0500, Theodore Ts'o wrote:

Hi Ted,

 > Could you please change this to read version 1.30 of e2fsprogs?  There
 > were some rare conditions where e2fsck could get confused with htree
 > directories in e2fsprogs 1.29 that were fixed in 1.30.  None of the
 > htree-related e2fsck bugs in 1.29 were catastrophic in the sense of
 > causing data loss, but they might cause confusion and spurious kernel
 > bug reports.

 For now, I've moved the htree things off the list on Andreas Dilger's
 request in light of the corruption reports that were mentioned.
 Are you any closer in nailing those issues ?

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
