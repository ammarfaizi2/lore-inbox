Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263094AbTCSSUs>; Wed, 19 Mar 2003 13:20:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263099AbTCSSUr>; Wed, 19 Mar 2003 13:20:47 -0500
Received: from fmr06.intel.com ([134.134.136.7]:35040 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id <S263094AbTCSSUq>; Wed, 19 Mar 2003 13:20:46 -0500
Message-ID: <65D5A07B5098D511BDDA0002A508E64F0995E8EF@orsmsx110.jf.intel.com>
From: "Brugger, Andrea L" <andrea.l.brugger@intel.com>
To: "'clg-discussion@osdl.org'" <clg-discussion@osdl.org>,
       "'linux-ha-dev@lists.community.tummy.com'" 
	<linux-ha-dev@lists.community.tummy.com>,
       "'ocf@lists.community.tummy.com'" <ocf@lists.community.tummy.com>,
       "'openipmi-developer@lists.sourceforge.net'" 
	<openipmi-developer@lists.sourceforge.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'freshmeat-news@lists.freshmeat.net'" 
	<freshmeat-news@lists.freshmeat.net>
Subject: [ANNOUNCE] OpenHPI -- an implementation for SAForum's HPI 
Date: Wed, 19 Mar 2003 10:31:33 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Project Announcement:

I'd like to introduce the OpenHPI project at http://openhpi.sf.net.  The
intent of this project is to produce an implementation of the Service
Availability Forum's Hardware Platform Interface (HPI).  HPI provides a
universal interface for creating resource system models, typically for
chassis and rack based servers, but extendable for other problem domains
such as clustering, virtualization, and simulation.

We are currently in the design phase of the project and are soliciting
involvement with others in the community.  

Our goal is to have modular hardware support that can be implemented using a
plugin architecture.  This would allow a top-level OpenHPI implementation to
be independent of the underlying hardware platform(s).  We are also just
getting a build environment up and a stubbed-out library implementation
available.  Work has also just begun regarding the planning and development
of a certification suite for the HPI implementation.  

For more information and how you can become involed please see...

Project Website: 
http://openhpi.sf.net

Mailing List: 
http://lists.sourceforge.net/lists/listinfo/openhpi-devel


-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
Andrea Brugger
Software Engineer 
Intel Corporation -- Telecom Software Programs
 
This email message does not necessarily represent or express the opinions of
Intel Corporation.
