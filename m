Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266244AbUFPLYg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266244AbUFPLYg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 07:24:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266245AbUFPLYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 07:24:36 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:44502 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S266244AbUFPLXl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 07:23:41 -0400
Subject: Re: ld segfault at end of 2.6.6 compile
From: Geoff Mishkin <gmishkin@comcast.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1087385018.8669.36.camel@amsa>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Jun 2004 07:23:39 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried it again with linux-2.6.7-rc3, but got the same error.

My glibc version is 2.3.3.20040420.  The kernel still compiles fine on
my other machine.  I also compiled on the nonworking machine with the
same .config as the working one, and still got the same problem.

			--Geoff Mishkin <gmishkin@bu.edu>

