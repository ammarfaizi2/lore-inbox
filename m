Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291415AbSBMGgM>; Wed, 13 Feb 2002 01:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291418AbSBMGfw>; Wed, 13 Feb 2002 01:35:52 -0500
Received: from dsl-65-185-241-169.telocity.com ([65.185.241.169]:2432 "EHLO
	mail.temp123.org") by vger.kernel.org with ESMTP id <S291415AbSBMGfp>;
	Wed, 13 Feb 2002 01:35:45 -0500
Date: Wed, 13 Feb 2002 01:35:48 -0500
From: Faux Pas III <fauxpas@temp123.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 Oops, maybe LVM ?
Message-ID: <20020213063548.GA463@temp123.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting reproducible oopses whenever I pull a file over the network
off of my LVM filesystem, so not exactly sure where this is coming
from...  this happens with vanilla 2.4.17 although the kernel that I 
captured the oops output from has LVM 1.0.2 and posix acls patches on
it.

Raw oops text and ksymoops output are at http://www.burdell.org/~fauxpas/

-- 
Josh Litherland (fauxpas@temp123.org)
