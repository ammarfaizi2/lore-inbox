Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262292AbUCEJuq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 04:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262444AbUCEJuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 04:50:46 -0500
Received: from main.gmane.org ([80.91.224.249]:64927 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262292AbUCEJup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 04:50:45 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Per Andreas Buer <perbu@linpro.no>
Subject: Re: [Jfs-discussion] Re: Desktop Filesystem Benchmarks in 2.6.3
Date: Thu, 04 Mar 2004 21:43:44 +0100
Organization: -
Message-ID: <PERBUMSGID-ul6y8qgibr3.fsf@nfsd.linpro.no>
References: <4044119D.6050502@andrew.cmu.edu> <40453538.8050103@animezone.org>
 <20040303014115.GP19111@khan.acc.umu.se>
 <200403030700.57164.robin.rosenberg.lists@dewire.com>
 <1078307033.904.1.camel@teapot.felipe-alfaro.com>
 <1078411067.40473f3b6b835@webmail.uni-konstanz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: nfsd.linpro.no
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.2 (gnu/linux)
Cancel-Lock: sha1:luoBCwtb7BbeF7Jayc3TnI6bGw8=
Cc: ext2-devel@sourceforge.net, Ext3-users@redhat.com,
       jfs-discussion@www-124.ibm.com, reiserfs-list@namesys.com,
       linux-xfs@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pascal Gienger <pascal.gienger@uni-konstanz.de> writes:

> 2. Speaking for servers, we live in a RAID and/or SAN-world. The media
> error issue is a non-issue.

If your cooling system stops you will experience media errors. A
filesystem which detects this halts the kernel really helps.

-- 
There are only 10 different kinds of people in the world, 
those who understand binary, and those who don't.

