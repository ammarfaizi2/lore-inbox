Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030934AbWKOT2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030934AbWKOT2Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 14:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030937AbWKOT2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 14:28:24 -0500
Received: from thunk.org ([69.25.196.29]:41947 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1030934AbWKOT2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 14:28:22 -0500
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: 2007 Linux Storage & Filesystem Workshop
From: "Theodore Ts'o" <tytso@mit.edu>
Phone: (781) 391-3464
Message-Id: <E1GkQQv-0001ZV-8X@candygram.thunk.org>
Date: Wed, 15 Nov 2006 14:28:29 -0500
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The submission date for the Linux Storage and Filesystem Workshop is
coming up quickly, and I'd encourage folks who are interested to submit
a 2-3 paragraph position statement.  

						- Ted

http://www.usenix.org/events/lsf07/cfp/

2007 Linux Storage & Filesystem Workshop Call for Position Statements

2007 Linux Storage & Filesystem Workshop
February 12--13, 2007
San Jose, CA

Co-located with the 5th USENIX Conference on File and Storage
Technologies (FAST '07), which will take place February
13--16, 2007

Important Dates
Submissions due: November 24, 2006
Notification of acceptance: December 15, 2006

Workshop Organizers

Program Chair
Ric Wheeler, EMC

Program Committee
Jens Axboe, Oracle
James Bottomley, SteelEye
Valerie Henson, Intel
Andrew Morton, Google
Trond Myklebust, Network Appliance
Brian Pawlowski, Network Appliance
Theodore Ts'o, IBM

Overview

The Linux Storage and Filesystem Workshop is a small, tightly focused,
by-invitation workshop. It is intended to bring together developers and
researchers interested in implementing improvements in the Linux
filesystem and storage subsystems that can find their way into the
mainline kernel and into Linux distributions in the 2--3-year
timeframe. The workshop will be two days, the second day overlapping
with FAST '07 tutorials. The workshop will be separated into storage and
filesystem tracks, with a combined plenary session.

Topics and Submissions

Researchers and developers who are interested in attending should submit
a 2--3-paragraph position statement that describes the topic or topics
they would like to discuss during the workshop, and whether such a topic
would suit the filesystem track, the storage track, or the plenary
session. Examples of topics of interest include:

    * New trends in storage technologies likely to impact Linux in the 
	next 3--5 years
    * More realistic methods of measuring filesystem and storage performance
    * Proposed improvements to Linux filesystems, including, in particular:
          o Handling of storage errors
          o Filesystem repair techniques
          o Scaling to very large (terabyte) filesystems
    * Progress reports on implementation of features discussed at the 
	Portland Filesystem Summit
    * Changes to the interface between the operating system and storage devices
    * Proposed improvements to existing Linux storage subsystems, 
		particularly with an emphasis on:
          o Refactoring common code out of storage subsystems and into 
		the block layer
          o Better robustness and error recovery
          o Barrier implementations in the face of TCQ
          o Making use of storage capabilities (such as block guard or 
		non-power-of-2 block sizes) for novel filesystem and 
		application features
    * Progress reports on implementation of features discussed at the 
	Vancouver Storage Summit
    * Userspace tools for managing storage systems (including better 
	presentation to the user via sysfs)
    * Storage futures, including:
          o New transports
          o Changes to existing standards for new storage features
          o SAS/SATA convergence
          o Do we yet have a use for Object-Based Storage Devices (OSD)?
