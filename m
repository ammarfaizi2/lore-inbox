Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263485AbTHXMrO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 08:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263495AbTHXMrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 08:47:14 -0400
Received: from mail15.speakeasy.net ([216.254.0.215]:16339 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S263485AbTHXMrM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 08:47:12 -0400
Subject: 2.4.22-rc3 ACPI & thinkpad t30
From: Samuel Meder <meder@mcs.anl.gov>
Reply-To: meder@mcs.anl.gov
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: University of Chicago
Message-Id: <1061729230.460.10.camel@titan.mcs.anl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 24 Aug 2003 07:47:10 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I can't seem to get ACPI working correctly on my thinkpad. I've
installed the latest BIOS and embedded controller (so no longer have the
bad ECDT table problem). The result is very similar to what was reported
in 

http://bugme.osdl.org/show_bug.cgi?id=793

(let me know if my dmesg output is required). I tried turning on ACPI
debugging to get more info, but that locks my machine solid on boot and
the actual traces fly by before I can catch them. I've also tried the
relaxed parsing option, but that doesn't seem to make any difference.

Any ideas?

/Sam

