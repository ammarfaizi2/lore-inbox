Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262441AbUJ0P0s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262441AbUJ0P0s (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 11:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbUJ0P0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 11:26:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:39115 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262441AbUJ0P0q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 11:26:46 -0400
Date: Wed, 27 Oct 2004 08:26:44 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200410271526.i9RFQiJR014342@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.10-rc1 - 2004-10-26.21.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/sctp/socket.c:2674: warning: format argument is not a pointer (arg 5)
