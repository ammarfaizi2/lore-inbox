Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbULUXy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbULUXy2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 18:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261905AbULUXy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 18:54:28 -0500
Received: from mail.dif.dk ([193.138.115.101]:6632 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261899AbULUXyP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 18:54:15 -0500
Date: Wed, 22 Dec 2004 01:04:59 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Juan-Mariano de Goyeneche <jmseyas@dit.upm.es>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Documentation: kernel-docs.txt - add a few sites   and tiny
 URL cleanups
Message-ID: <Pine.LNX.4.61.0412220056470.3518@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Here's a patch that a) adds an entry for a new site (KernelTrap), b) adds 
proper trailing slashes to the end of URLs missing them, and c) adds a few 
more linux-kernel mailing list archives and search engines.

Please consider applying :-)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -u linux-2.6.10-rc3-bk13-orig/Documentation/kernel-docs.txt linux-2.6.10-rc3-bk13/Documentation/kernel-docs.txt
--- linux-2.6.10-rc3-bk13-orig/Documentation/kernel-docs.txt	2004-10-18 23:54:37.000000000 +0200
+++ linux-2.6.10-rc3-bk13/Documentation/kernel-docs.txt	2004-12-22 01:01:45.000000000 +0100
@@ -659,7 +659,7 @@
        be more up to date than the web version.
        
      * Name: "Linux Source Driver"
-       URL: http://lsd.linux.cz
+       URL: http://lsd.linux.cz/
        Keywords: Browsing source code.
        Description: "Linux Source Driver (LSD) is an application, which
        can make browsing source codes of Linux kernel easier than you can
@@ -687,7 +687,7 @@
        where they are defined and where they are used.
        
      * Name: "Linux Weekly News"
-       URL: http://lwn.net
+       URL: http://lwn.net/
        Keywords: latest kernel news.
        Description: The title says it all. There's a fixed kernel section
        summarizing developers' work, bug fixes, new features and versions
@@ -700,7 +700,7 @@
        discussions of the linux-kernel mailing list.
        
      * Name: "CuTTiNG.eDGe.LiNuX"
-       URL: http://edge.kernelnotes.org
+       URL: http://edge.kernelnotes.org/
        Keywords: changelist.
        Description: Site which provides the changelist for every kernel
        release. What's new, what's better, what's changed. Myrdraal reads
@@ -746,7 +746,7 @@
        it if you are interested in memory management development!
        
      * Name: "Kernel Newbies IRC Channel"
-       URL: http://www.kernelnewbies.org
+       URL: http://www.kernelnewbies.org/
        Keywords: IRC, newbies, channel, asking doubts.
        Description: #kernelnewbies on irc.openprojects.net. From the web
        page: "#kernelnewbies is an IRC network dedicated to the 'newbie'
@@ -758,10 +758,21 @@
        server and then /join #kernelnewbies". It also hosts articles,
        documents, FAQs...
        
+     * Name: "KernelTrap"  
+       URL: http://kerneltrap.org/
+       Keywords: community, discussion, news, forums, interviews, 
+       journals.
+       Description: KernelTrap is a web community devoted to sharing the
+       latest in kernel development news. It also has interviews with 
+       developers, developer blogs/journals and much more. It's not 
+       Linux only (but mainly).
+       
      * Name: "linux-kernel mailing list archives and search engines"
        URL: http://www.uwsg.indiana.edu/hypermail/linux/kernel/index.html
        URL: http://www.kernelnotes.org/lnxlists/linux-kernel/
-       URL: http://www.geocrawler.com
+       URL: http://groups-beta.google.com/group/linux.kernel/
+       URL: http://www.geocrawler.com/
+       URL: http://lkml.org/
        Keywords: linux-kernel, archives, search.
        Description: Some of the linux-kernel mailing list archivers. If
        you have a better/another one, please let me know.



