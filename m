Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263961AbUDNIGv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 04:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263951AbUDNIGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 04:06:51 -0400
Received: from painless.aaisp.net.uk ([217.169.20.17]:52365 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S263961AbUDNIGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 04:06:36 -0400
Message-ID: <407CF31D.8000101@rgadsdon2.giointernet.co.uk>
Date: Wed, 14 Apr 2004 09:15:25 +0100
From: Robert Gadsdon <robert@rgadsdon2.giointernet.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-GB; rv:1.7b) Gecko/20040320
X-Accept-Language: en-gb, en, en-us
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: linux kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.5-bk1 breaks VMware compile..
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.5-bk1 breaks the VMware compile (similar problem with 2.6.5-mm5). 
This is fixed by Sam Ravnborg's kbuild patch (see previous LKML 
message).   This should also fix problems with broken Nvidia (non-free) 
compiles..


Robert Gadsdon.

