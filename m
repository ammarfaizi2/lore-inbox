Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265795AbUHYOeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUHYOeO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUHYOeO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:34:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:65505 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265795AbUHYOeO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:34:14 -0400
Date: Wed, 25 Aug 2004 07:34:12 -0700
From: John Cherry <cherry@osdl.org>
Message-Id: <200408251434.i7PEYCLM025591@cherrypit.pdx.osdl.net>
To: linux-kernel@vger.kernel.org
Subject: IA32 (2.6.9-rc1 - 2004-08-24.21.30) - 1 New warnings (gcc 3.2.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/usb/gadget/inode.c:693: warning: assignment from incompatible pointer type
