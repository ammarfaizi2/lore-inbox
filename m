Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbWEOJxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbWEOJxn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 05:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964852AbWEOJxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 05:53:43 -0400
Received: from [202.125.80.34] ([202.125.80.34]:13854 "EHLO
	esnmail.esntechnologies.co.in") by vger.kernel.org with ESMTP
	id S964850AbWEOJxm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 05:53:42 -0400
Subject: GPL and NON GPL version modules
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Mon, 15 May 2006 15:23:30 +0530
Message-ID: <AF63F67E8D577C4390B25443CBE3B9F70928E8@esnmail.esntechnologies.co.in>
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: GPL and NON GPL version modules
thread-index: AcZ4AmMn6A3GX7qyQ76gWH4oEWSHbAAArE2g
From: "Srinivas G." <srinivasg@esntechnologies.co.in>
To: "linux-kernel-Mailing-list" <linux-kernel@vger.kernel.org>
Cc: "Fawad Lateef" <fawadlateef@gmail.com>, <jjoy@novell.com>,
       "Nutan C." <nutanc@esntechnologies.co.in>,
       "Mukund JB." <mukundjb@esntechnologies.co.in>, <gauravd.chd@gmail.com>,
       <bulb@ucw.cz>, <greg@kroah.com>, "Shakthi Kannan" <cyborg4k@yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,
 
I have a small doubt about the GPL and NON GPL version modules.

If I have a module called module A which uses the GPL code and module B
uses the NON GPL (proprietary) code. If the module A depends on module
B, is it possible to load these modules? That is some of the functions
(which are defined in module B) are called from module A.

Will it be violating any GPL Rules?

Regards,
Srinivas G
