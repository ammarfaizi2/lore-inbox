Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261361AbTISGgL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 02:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbTISGgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 02:36:10 -0400
Received: from cafe.hardrock.org ([142.179.182.80]:62118 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S261376AbTISGgI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 02:36:08 -0400
Date: Fri, 19 Sep 2003 00:36:07 -0600 (MDT)
From: James Bourne <jbourne@hardrock.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-uv2 patch set released
Message-ID: <Pine.LNX.4.44.0309190031570.19377-100000@cafe.hardrock.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I've placed the update version 2 (2.4.22-uv2) patch set for 2.4.22 at 
http://www.hardrock.org/kernel/current-updates/ for those who want to
download it. 

A 00README file can be found at
http://www.hardrock.org/kernel/current-updates/00README
and contains a brief description of all the bits in the patch.

This patch set only contains and will only contain security updates and
fixes for the latest kernel version.  Each individual patch contains text
WRT the patch itself and the creator of the patch, I will try to keep doing
that as standard reference for the complete collection.

The only changes from -uv1 to -uv2 are the inclusion of the serial USB patch
from Greg K-H which stops an oops condition within the USB Serial driver and
updating of the EXTRAVERSION.

Please send bug reports to jbourne@hardrock.org.

Regards
James Bourne

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  


