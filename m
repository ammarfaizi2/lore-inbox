Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268216AbUJCXFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268216AbUJCXFN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Oct 2004 19:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268218AbUJCXFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Oct 2004 19:05:13 -0400
Received: from sklave3.rackland.de ([213.133.101.23]:60642 "EHLO
	sklave3.rackland.de") by vger.kernel.org with ESMTP id S268216AbUJCXFH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Oct 2004 19:05:07 -0400
From: Hadmut Danisch <hadmut@danisch.de>
Date: Mon, 4 Oct 2004 01:03:00 +0200
To: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: NFS incompatible with Solaris jumpstart
Message-ID: <20041003230300.GA9057@danisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I want to jumpstart-install (initial installation of the 
Solaris operating system) a sparc machine from a linux server
with kernel 2.6.8.1.

It works when using the nfs-user-server, but the sparc hangs after 
printing the OS prompt when using the nfs-kernel-server.

Any idea in how the nfs-user-server and the nfs-kernel-server differ 
and how to fix it?

regards
Hadmut
