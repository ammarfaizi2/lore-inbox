Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263190AbTHWB2p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 21:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbTHWB2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 21:28:45 -0400
Received: from vitelus.com ([64.81.243.207]:65159 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S263288AbTHWB2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 21:28:39 -0400
Date: Fri, 22 Aug 2003 18:27:24 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: *sigh* something is wrong with bkcvs again
Message-ID: <20030823012724.GC31894@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the *root* of a fresh checkout:

$ head -2 Makefile 
#
# Copyright (c) 2000-2003 Silicon Graphics, Inc.  All Rights Reserved.

It's the XFS makefile...
