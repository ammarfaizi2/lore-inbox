Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVCIFgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVCIFgb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 00:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVCIFga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 00:36:30 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:37802 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261293AbVCIFg2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 00:36:28 -0500
Subject: Oops tracing and /proc
From: Lee Revell <rlrevell@joe-job.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 00:36:27 -0500
Message-Id: <1110346587.7123.14.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to decode an Oops per the instructions in
Documentation/oops-tracing.txt.  The instructions say to run it through
ksymoops with the "-k /proc/ksyms" argument.

But, I do not have this file!  The closest thing I have
is /proc/kallsyms.  ksymoops complains that it does not understand the
syntax of this file.

What am I doing wrong?

Lee

