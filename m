Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270686AbTG0Guw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 02:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270687AbTG0Guw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 02:50:52 -0400
Received: from fisek2.ada.net.tr ([195.112.153.19]:22546 "HELO
	mail.fisek.com.tr") by vger.kernel.org with SMTP id S270686AbTG0Gut
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 02:50:49 -0400
Date: Sun, 27 Jul 2003 10:02:46 +0300
From: Doruk Fisek <dfisek@fisek.com.tr>
To: linux-kernel@vger.kernel.org
Subject: hw tcp v4 csum failed
Message-Id: <20030727100246.4bfb860c.dfisek@fisek.com.tr>
Organization: Fisek Enstitusu
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 I am getting "hw tcp v4 csum failed" errors using a BCM5701 ethernet
adapter with the tigon3 driver in a vanilla 2.4.20 kernel.

 There seems to be no apparent problem (probably because of low-load).

 What can be the cause of these errors?

                               Doruk

--
FISEK INSTITUTE -- http://www.fisek.org
