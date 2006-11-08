Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161491AbWKHSn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161491AbWKHSn0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 13:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161493AbWKHSn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 13:43:26 -0500
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:64108
	"EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP
	id S1161491AbWKHSnZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 13:43:25 -0500
content-class: urn:content-classes:message
Subject: How to compile module params into kernel?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Wed, 8 Nov 2006 19:43:22 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D939AA94F9@tmnt04.transmode.se>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to compile module params into kernel?
Thread-Index: AccDZb5fs/7EapKURbq9t871smnZpg==
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of passing a module param on the cmdline I want to compile that
into
the kernel, but I can't figure out how.

The module param I want compile into kernel is
rtc-ds1307.force=0,0x68

This is for an embeddet target that doesn't have loadable module
support.

 Thanks
      Jocke
