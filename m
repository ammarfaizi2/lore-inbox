Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030191AbWHHTTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030191AbWHHTTQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030188AbWHHTTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:19:16 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:50610 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030191AbWHHTTP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:19:15 -0400
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Tue, 8 Aug 2006 21:18:09 +0200 (CEST)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH 0/4] ieee1394: misc updates
To: linux-kernel@vger.kernel.org
cc: Ben Collins <bcollins@ubuntu.com>, Andrew Morton <akpm@osdl.org>,
       linux1394-devel@lists.sourceforge.net
Message-ID: <tkrat.57bb8cb1b7c97d1e@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are four small updates for the 1394 subsystem. They were already
seen on linux1394-devel.

David Moore:
    video1394: add poll file operation support

Stefan Richter:
    ieee1394: safer definition of empty macros
    ieee1394: sbp2: workaround for write protect bit of Initio firmware
    ieee1394: sbp2: enable auto spin-up for all SBP-2 devices
-- 
Stefan Richter
-=====-=-==- =--- -=---
http://arcgraph.de/sr/

