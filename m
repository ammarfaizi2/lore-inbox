Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261308AbTCGAtg>; Thu, 6 Mar 2003 19:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261311AbTCGAtg>; Thu, 6 Mar 2003 19:49:36 -0500
Received: from pollux.ds.pg.gda.pl ([213.192.76.3]:24583 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261308AbTCGAtg>; Thu, 6 Mar 2003 19:49:36 -0500
Date: Fri, 7 Mar 2003 02:00:01 +0100 (CET)
From: =?ISO-8859-2?Q?Pawe=B3_Go=B3aszewski?= <blues@ds.pg.gda.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.5.64] depmod problem
Message-ID: <Pine.LNX.4.51L.0303070158580.14030@piorun.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When making depmod on fresh 2.5.64 I get:

# /sbin/depmod -ae -F System.map  2.5.64
WARNING: /lib/modules/2.5.64/kernel/drivers/hotplug/acpiphp.ko needs unknown symbol acpi_resource_to_address64

-- 
---------------------------------
pozdr.  Pawe³ Go³aszewski        
---------------------------------
CPU not found - software emulation...
