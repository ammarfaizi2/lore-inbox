Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265087AbUFGVvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265087AbUFGVvW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 17:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbUFGVvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 17:51:22 -0400
Received: from eik.ii.uib.no ([129.177.16.3]:20615 "EHLO eik.ii.uib.no")
	by vger.kernel.org with ESMTP id S265088AbUFGVvV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 17:51:21 -0400
Date: Mon, 7 Jun 2004 23:51:16 +0200
From: Jan-Frode Myklebust <janfrode@parallab.uib.no>
To: linux-kernel@vger.kernel.org
Subject: two crashes with 2.6.6
Message-ID: <20040607215116.GA26758@ii.uib.no>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've experienced a few crashes on my NFS-fileserver running vanilla
2.6.6, and serving XFS filesystems. The first is reported in:

	http://bugme.osdl.org/show_bug.cgi?id=2840

This has happened I think 3 times the last 3 weeks. And after the last
crash I also experienced XFS internal errors and a umount oops:

	http://bugme.osdl.org/show_bug.cgi?id=2841

Hope these reports are usefull..


  -jf
