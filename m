Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267383AbSLERs5>; Thu, 5 Dec 2002 12:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267389AbSLERs4>; Thu, 5 Dec 2002 12:48:56 -0500
Received: from air-2.osdl.org ([65.172.181.6]:17843 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267383AbSLERs4>;
	Thu, 5 Dec 2002 12:48:56 -0500
Date: Thu, 5 Dec 2002 09:56:22 -0800
From: Dave Olien <dmo@osdl.org>
To: cobra@compuserve.com
Cc: _deepfire@mail.ru, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: DAC960 patch for 2.4.20aa1
Message-ID: <20021205095622.A6787@acpi.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If anyone's interested, I have a patch for the DAC960 driver
that makes it compile and (I THINK) work with the 2.4.20aa1
patch.

You can find it in my public archive in

	http://www.osdl.org/archive/dmo/DAC960_2.4.20aa1

It's had minimal testing.  Mark Wong at OSDL is using this patch
run some database workloads.  That should be a reasonable sanity
test for this patch.

Dave Olien
