Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262454AbTD3Vv6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 17:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbTD3Vv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 17:51:58 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:9446 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S262451AbTD3VvD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 17:51:03 -0400
Date: Wed, 30 Apr 2003 17:59:50 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Loading a module multtiple times
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Message-ID: <200304301803_MC3-1-36C6-148@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:

>  Error inserting 'dummy1.ko': -1 File exists

  Duplicate kobject/sysfs name?

------
 Chuck
