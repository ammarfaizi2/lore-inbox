Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263738AbTEEQnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 12:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbTEEQYn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 12:24:43 -0400
Received: from franka.aracnet.com ([216.99.193.44]:705 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263650AbTEEQYb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 12:24:31 -0400
Date: Mon, 05 May 2003 09:36:28 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 648] New: sysfs initialisation failure. 
Message-ID: <10450000.1052152588@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=648

           Summary: sysfs initialisation failure.
    Kernel Version: 2.5.68
            Status: NEW
          Severity: normal
             Owner: mochel@osdl.org
         Submitter: davej@codemonkey.org.uk


It's possible in some configurations that sysfs goes splat during
initialisation. See oops attachment

