Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265093AbSKESWj>; Tue, 5 Nov 2002 13:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265094AbSKESWj>; Tue, 5 Nov 2002 13:22:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65285 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265093AbSKESWi>; Tue, 5 Nov 2002 13:22:38 -0500
Subject: PATCH: Driver Maintainers
To: torvalds@transmeta.com
Date: Tue, 5 Nov 2002 18:22:31 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E1898LP-0003Ie-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been getting more and more people talking to me looking to pay people to 
fix small Linux bugs but having problems finding smaller companies. Obviously
wanting to send $1000 to have someone fix a driver simply doesn't work when
you talk to big companies.

One thing the FSF do which is rather sensible is keep a list in the packages
of people who you can pay to fix stuff in them. I asked on Linux-kernel
and got a small initial set of company responses. hopefully more will appear
once its merged.

The order is alphabetical logically enough

[Marcelo this seems to apply cleanly to 2.4 as well]

Alan
--


--- ../linux.2.5.46/MAINTAINERS	2002-11-05 13:54:42.000000000 +0000
+++ MAINTAINERS	2002-11-05 16:11:31.000000000 +0000
@@ -1,6 +1,9 @@
 
 	List of maintainers and how to submit kernel changes
 
+ (Please also see Documentation/DriverFixers for people who offer driver
+	 development and fixing as a business)
+
 Please try to follow the guidelines below.  This will make things
 easier on the maintainers.  Not all of these guidelines matter for every
 trivial patch so apply some common sense.
--- /dev/null	2002-08-31 00:31:37.000000000 +0100
+++ Documentation/DriverFixers	2002-11-05 18:41:26.000000000 +0000
@@ -0,0 +1,37 @@
+People who fix drivers as a business - ie for money. (No recommendation,
+business association or other relationship implied. This for the benefit of 
+American lawyers is just a list of people who have asked to be listed - nothing
+more).
+
+
+Company:	BitWizard
+Contact:	Rogier Wolff
+E-Mail:		R.E.Wolff@BitWizard.nl
+
+Company:	Caederus
+Contact:	Justin Mitchell
+E-Mail:		info@caederus.com
+URL:		http://www.caederus.com/
+Location:	Swansea, Wales, UK
+
+Company:	Weinigel Ingenjörsbyrå AB
+Contact:	Christer Weinigel
+E-Mail:		christer@weinigel.se
+Location:	Stockholm, Sweden
+
+Company:	WildOpenSource
+Contact:	Martin Hicks
+E-Mail:		info@wildopensource.com
+
+
+To be added to the list: email <alan@lxorguk.ukuu.org.uk> giving the
+following information
+
+Company:	CompanyName		[Required]
+Contact:	ContactName		[Required]
+E-Mail:		An email address	[Required]
+URL:		Web site		[Optional]
+Location:	Area/Country		[Optional]
+Telephone:	Contact phone number	[Optional]
+Notes:		Any other notes (eg certifications, specialities)
+
