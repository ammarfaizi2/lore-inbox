Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262952AbUJ1UMD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbUJ1UMD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 16:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262892AbUJ1UHG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 16:07:06 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:12964 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP id S262728AbUJ1UFo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 16:05:44 -0400
From: james4765@verizon.net
To: linux-kernel@vger.kernel.org
Cc: rusty@rustcorp.com.au, james4765@verizon.net
Message-Id: <20041028200540.4340.4431.73847@localhost.localdomain>
Subject: [PATCH 0/3] updating digiboard status
X-Authentication-Info: Submitted using SMTP AUTH at out001.verizon.net from [209.158.211.53] at Thu, 28 Oct 2004 15:05:40 -0500
Date: Thu, 28 Oct 2004 15:05:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The digiboard driver is obsoleted by digiecpa.  This set of patches removes the
help file in ./Documentation and puts the correct status in MAINTAINERS.
