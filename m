Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUCOSgM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 13:36:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbUCOSgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 13:36:12 -0500
Received: from fmr06.intel.com ([134.134.136.7]:57773 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262585AbUCOSgJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 13:36:09 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: 2.6.4 & new e100 driver: module load parameters
Date: Mon, 15 Mar 2004 10:35:30 -0800
Message-ID: <C6F5CF431189FA4CBAEC9E7DD5441E0103AF5E72@orsmsx402.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.6.4 & new e100 driver: module load parameters
Thread-Index: AcQJ9V+6/q5OYiH8SkubWXeqo8HAgQAx2tDA
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "Calum Mackay" <calum.mackay@cdmnet.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Mar 2004 18:35:31.0266 (UTC) FILETIME=[4BA83220:01C40ABC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does the new driver support module-load-time configuration of 
> these settings, or do I now need a startup script that hacks 
> around with ethtool?

Use ethtool.
 
> [and perhaps the e100.txt file needs to be updated?]

Yes, I need to do that.  Thanks for the reminder.

-scott
