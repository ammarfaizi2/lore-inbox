Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261230AbUCDHKu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Mar 2004 02:10:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261528AbUCDHKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Mar 2004 02:10:49 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:24540 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S261230AbUCDHKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Mar 2004 02:10:48 -0500
To: "kernel mailing list" <linux-kernel@vger.kernel.org>
Subject: How to black list shared libraries and executable
Date: Thu, 04 Mar 2004 15:10:34 +0800
From: "Michael Frank" <mhf@linuxmail.org>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr4bsvwbj4evsfm@smtp.pacific.net.th>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wondering on how to build a kernel-level facility which would
require shared libraries and executables to be "keyed" or even
"signed" to run on linux.

This is to prevent execution of software not specifically authorized.

Applications:

- Improve security
- License management
- Prevent unauthorized software installation
- Black-listing e.g. SCO libraries and executables

Regards
Michael
