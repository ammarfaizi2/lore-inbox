Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131224AbRCWQY7>; Fri, 23 Mar 2001 11:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131227AbRCWQYx>; Fri, 23 Mar 2001 11:24:53 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62222 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S131224AbRCWQYa>;
	Fri, 23 Mar 2001 11:24:30 -0500
Date: Fri, 23 Mar 2001 16:23:45 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: NTP on 2.4.2?
Message-ID: <20010323162345.A24604@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm having problems getting my 2.4.2 kernel to synchronise properly.  For
some reason, NTP is insisting on making time offset adjustments.

Is anyone else using NTP with 2.4.2, and if so, are you synchronising
properly?

(I'm using the RH7.0 version of ntp-4.0.99j here)

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

