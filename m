Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265388AbRFWBJs>; Fri, 22 Jun 2001 21:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265392AbRFWBJi>; Fri, 22 Jun 2001 21:09:38 -0400
Received: from suntan.tandem.com ([192.216.221.8]:52132 "EHLO
	suntan.tandem.com") by vger.kernel.org with ESMTP
	id <S265388AbRFWBJa>; Fri, 22 Jun 2001 21:09:30 -0400
From: bruce@kahuna.cag.cpqcorp.net
Message-Id: <200106230054.f5N0sDJ02195@kahuna.cag.cpqcorp.net>
To: linux-cluster@nl.linux.org, linux-kernel@vger.kernel.org
Date: Fri, 22 Jun 2001 17:50 PDT
Subject: Compaq launches Open SSI Cluster Projects
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Compaq has launched two open source technology projects
under the GPL license.  They are briefly described below 
and can be found through www.opensource.compaq.com.

We are actively looking for technology partners, 
contributors, consultants and general kibitzers to
participate via the email lists set up for each project.
Those that just want to monitor the projects are welcome
as well.

Cluster Infrastructure for Linux (CI)
  The goal of this project is to develop a common 
infrastructure for many if not all forms of Linux 
clustering by extending the Cluster Membership and 
Inter-node Communication Subsystems from Compaq's 
NonStop Clusters for Unixware code base.  This project 
also provides the basis for the Open SSI Clusters for 
Linux project.  
   A developers download is available via
www.opensource.compaq.com for Intel-32, along 
with build, boot, hook, interface and api documentation.
We will put the CVS repository on the web when we can.
A port to the alpha chip has already succeeded and 
patches for that are available.

Open Single System Image (SSI) Clusters for Linux Project
   The Open SSI project leverages both Compaq's NonStop
Clusters for Unixware technology and other open source
technology to provide a full, highly available SSI
environment for Linux.  Goals for SSI Clusters include
availability, scalability and manageability, built from
standard servers.  Technology pieces will include:
membership, single root and single init, cluster filesystems
and DLM, single process space and process migration, load
leveling, availability monitors and failover, single namespace  
and shared access for all forms of IPC, devices and networking, 
and a single management space.  The SSI project will leverage 
the Cluster Infrastructure for Linux project.
   Source beyond the CI base is not yet available.  We are
aiming for a developers release of much of functionality in
July.  In the meantime there is a presentation on SSI
Clustering on the web. An initial list of component requirements 
will soon be posted for discussion and refinement.
Join the mail alias via www.opensource.compaq.com
to stay updated.

bruce walker
SSI Cluster Architect
Linux Program Office
Compaq Computers
