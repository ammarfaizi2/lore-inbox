Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262945AbTDFMhK (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 08:37:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262948AbTDFMhK (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 08:37:10 -0400
Received: from smtp01.web.de ([217.72.192.180]:14111 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262945AbTDFMhJ (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 08:37:09 -0400
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: linux-kernel@vger.kernel.org
Subject: Serial port over TCP/IP
Date: Sun, 6 Apr 2003 14:47:46 +0200
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304061447.46393.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Is it possible to make a char-dev (a serial device ttyS0)
available via TCP/IP on a network like it is possible
for block-devices like a harddisk via nbd?
Is kernel-support for this present?
If not, is it technically possible to develop such a driver?

Thanks.
Regards Michael Buesch.

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

