Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbTIDJwN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 05:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbTIDJwN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 05:52:13 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:15001 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261649AbTIDJwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 05:52:11 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Thu, 4 Sep 2003 11:52:09 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Compiling an i386 kernel on AMD Opteron
Message-Id: <20030904115209.56e019b1.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.5 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

is it possible to compile a kernel on Opteron for i386 (32-bit) and not 64 bit
Opteron with usual make procedures?

When I do a simple "make menuconfig" I can only see the Opteron processor type
in "Processor type and features" ...

Regards,
Stephan
