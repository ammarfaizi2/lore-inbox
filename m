Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266712AbTATUeF>; Mon, 20 Jan 2003 15:34:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbTATUeF>; Mon, 20 Jan 2003 15:34:05 -0500
Received: from ostia.INS.CWRU.Edu ([129.22.8.4]:44496 "EHLO ostia.INS.cwru.edu")
	by vger.kernel.org with ESMTP id <S266712AbTATUeE>;
	Mon, 20 Jan 2003 15:34:04 -0500
Date: Mon, 20 Jan 2003 15:43:03 -0500
From: Justin Hibbits <jrh29@po.cwru.edu>
To: linux-kernel@vger.kernel.org
Subject: LFS problems
Message-ID: <20030120204303.GA459@lothlorien.cwru.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For some reason, within the last 3 months, I've lost the ability to create
files, and format filesystems, larger than 4GB.  I'm using kernel 2.4.18 with
the XFS patch.  I'm trying to format a new filessytem, 120GB, as XFS, (also
tried as ext2), but get the error "Filesize limit exceeded".  Is there
something I'm missing?  I'm using the same exact kernel, and nothing else has
changed, except for some utilities.  I was able to create a 120GB XFS
filesystem in October, so I'm kinda perplexed as to why it would suddenly just
decide that I can't format filesystems to be larger than 4GB anymore.

Any ideas?

Thanks in advance,
Justin Hibbits

-- 
Registered Linux user 260206


