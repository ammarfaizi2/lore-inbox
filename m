Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261287AbUKWOox@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261287AbUKWOox (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 09:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbUKWOow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 09:44:52 -0500
Received: from smtp.cs.aau.dk ([130.225.194.6]:15753 "EHLO smtp.cs.aau.dk")
	by vger.kernel.org with ESMTP id S261269AbUKWOoN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 09:44:13 -0500
From: Kristian =?iso-8859-1?q?S=F8rensen?= <ks@cs.aau.dk>
Organization: Aalborg University
To: umbrella-announce@lists.sourceforge.net
Subject: Umbrella-0.5.1 stable released
Date: Tue, 23 Nov 2004 15:44:09 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200411231544.09701.ks@cs.aau.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

We are pleased to inform you that Umbrella 0.5.1 is now released. This is a 
very stable release, which has been tested on our workstations for 6+ days 
continously.

Get the release here: 
http://prdownloads.sourceforge.net/umbrella/umbrella-0.5.1.tar.bz2?download

The strategy of the further development of Umbrella is to have
* STABLE and well tested Umbrella as patches 
* UNSTABLE bleeding edge technology in the CVS module umbrella-devel


We have lots of new stuff and optimizations in the CVS, which slowley will be 
applied and tested before getting realeased as patches. Currently we have 
these in the CVS:
* New, small and efficient bit vector
* New datastructure for storing restrictions
   See this thread for details: 
   http://sourceforge.net/mailarchive/forum.php?thread_id=5886152&forum_id=42079
* Restrictions on process signaling
* Authentication of binaries (still under development for the 0.6 release)


Best regards,
Kristian Sørensen.


-- 
Kristian Sørensen
- The Umbrella Project  --  Security for Consumer Electronics
    http://umbrella.sourceforge.net

E-mail: ipqw@users.sf.net, Phone: +45 29723816
