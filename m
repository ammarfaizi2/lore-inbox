Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262177AbTJIPgs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 11:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbTJIPgs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 11:36:48 -0400
Received: from gw.nact.com ([209.210.211.18]:45325 "EHLO prv01-mxc01.verso.com")
	by vger.kernel.org with ESMTP id S262177AbTJIPgr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 11:36:47 -0400
Message-ID: <EC2C10A96067434BA007ACC3ADD31CE60262E0A8@prv01-mxc01.verso.com>
From: "Snelgrove, Steve" <SSnelgrove@nact.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Compile error in linux-2.6.0-test7.tar.gz
Date: Thu, 9 Oct 2003 09:36:05 -0600 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


While compiling the latest test build linux-2.6.0-test7.tar.gz,
I got the following compile error:

(hand copied)

CC    arch/sparc64/kernel/unaligned.o

cc1:  warnings being treated as errors
arch/sparc64/kernel/unaligned.c: In function 'decode_access_size'
arch/sparc64/kernel/unaligned.c: warning: control reaches end of non-void
function

