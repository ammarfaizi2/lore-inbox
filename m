Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbUKJMpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbUKJMpk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 07:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbUKJMpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 07:45:40 -0500
Received: from user-10mt71s.cable.mindspring.com ([65.110.156.60]:14961 "EHLO
	localhost") by vger.kernel.org with ESMTP id S261776AbUKJMnj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 07:43:39 -0500
Date: Wed, 10 Nov 2004 07:42:01 -0500
From: David Roundy <droundy@darcs.net>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] darcs mirror of the linux kernel repository
Message-ID: <20041110124158.GD31123@abridgegame.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am pleased to announce the availability of a darcs mirror of the linux
kernel repository.  Darcs is a fully distributed and simple to use revision
control system.  Instructions on accessing the repository are available at

http://darcs.net/linux.html


In brief, you can get a copy of the latest kernel (converted from the bkcvs
branch) using

darcs get --partial http://darcs.net/linux

You can leave out the --partial, if you want to get the full history of the
kernel repository (which obviously will take longer).


Be forewarned that darcs is a bit of a memory hog when run with large
repositories, so the above command may take quite a while, and probably
will require 700 or 800 megabytes of virtual memory.  The actual working
set of memory is under 300 megabytes.  Work is underway to improve both the
speed and memory usage of darcs.  So far the emphasis in darcs development
has been on correctness and stability.

The darcs kernel mirror is sponsored by Aktiom Networks
(http://aktiom.net). Aktiom specializes in Linux Virtual Private Servers
(VPS) for technology professionals and consultants.

-- 
David Roundy
http://www.darcs.net
