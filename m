Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312619AbSDXVkJ>; Wed, 24 Apr 2002 17:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312616AbSDXVkI>; Wed, 24 Apr 2002 17:40:08 -0400
Received: from takibi.datarithm.net ([64.81.244.37]:8810 "EHLO takibi.rmr")
	by vger.kernel.org with ESMTP id <S312608AbSDXVkG>;
	Wed, 24 Apr 2002 17:40:06 -0400
Date: Wed, 24 Apr 2002 14:39:50 -0700
From: robert read <rread@datarithm.net>
To: intermezzo-announce@lists.sourceforge.net
Cc: intermezzo-discuss@lists.sourceforge.net,
        intermezzo-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: ANNOUNCE: Intermezzo + Intersync 0.9.3 release
Message-ID: <20020424143949.A31043@datarithm.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A new version of intersync/intermezzo has been uploaded to 

ftp://ftp.inter-mezzo.org:/pub/intermezzo

The binary rpm now installs the source for the intermezzo module in
/usr/src/intermezzo-0.9.3, which needs to be configured and built for
your kernel. We will be submitting this for 2.4 soon.

What's new:
 - non-intermezzo readable files are replicated
 - full replicas are supported (not just data on demand) 
 - even simpler configuration: no need to specific channel or local
     port when replicating on the same host

Robert Read rread@computer.org
Peter Braam braam@clusterfs.com
Phil Schwan phil@clusterfs.com
