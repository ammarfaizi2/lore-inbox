Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267008AbTAKD2J>; Fri, 10 Jan 2003 22:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267013AbTAKD2J>; Fri, 10 Jan 2003 22:28:09 -0500
Received: from havoc.daloft.com ([64.213.145.173]:52694 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S267008AbTAKD2I>;
	Fri, 10 Jan 2003 22:28:08 -0500
Date: Fri, 10 Jan 2003 22:36:50 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: More on Linux and iSCSI [info, not flame :)]
Message-ID: <20030111033650.GA32137@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So I thought I would inject some info into the discussion. :)

Oliver Xymoron (and others?) mentioned that one could do iSCSI in
userspace.  Well, Intel has code at
	http://sourceforge.net/projects/intel-iscsi

Just looking at the todo and glancing at the code shows that it is far
from optimal, but at the same time it is open source and a working
starting point for anyone interested in optimizing it.

	Jeff




