Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270877AbTHKClo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 22:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271368AbTHKClo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 22:41:44 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:10438 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S270877AbTHKCkf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 22:40:35 -0400
Reply-To: <vlad@lrsehosting.com>
From: <vlad@lrsehosting.com>
To: "'Gerardo Exequiel Pozzi'" <vmlinuz386@yahoo.com.ar>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Modules fail to build / install in 2.6.0-test3
Date: Sun, 10 Aug 2003 21:39:44 -0500
Message-ID: <000701c35fb1$d3b5c120$0200a8c0@wsl3>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Importance: Normal
In-Reply-To: <000501c35faf$2fb718f0$0200a8c0@wsl3>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

However, after a successful build, and installation of
module-init-tools-0.9.13-pre2.tar.bz2, I get the same errors from test3.
Kernel builds (and is running) fine, it's just the modules in the last error
message that refuse to build.

--

 /"\                         / For information and quotes, email us at
 \ /  ASCII RIBBON CAMPAIGN / info@lrsehosting.com
  X   AGAINST HTML MAIL    / http://www.lrsehosting.com/
 / \  AND POSTINGS        / vlad@lrsehosting.com
-------------------------------------------------------------------------

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of
vlad@lrsehosting.com
Sent: Sunday, August 10, 2003 9:21 PM
To: 'Gerardo Exequiel Pozzi'
Cc: linux-kernel@vger.kernel.org
Subject: RE: Modules fail to build / install in 2.6.0-test3


Ack! No, I missed those, I have updated and am retrying 'make modules &&
make modules_install' now.  Thanks!


