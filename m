Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261870AbUL0L2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261870AbUL0L2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 06:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbUL0L2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 06:28:30 -0500
Received: from ns2.insysnet.ru ([81.18.141.4]:52747 "HELO mail.insysnet.ru")
	by vger.kernel.org with SMTP id S261870AbUL0L21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 06:28:27 -0500
Message-ID: <41CFF1D9.6030104@insysnet.ru>
Date: Mon, 27 Dec 2004 14:28:25 +0300
From: Alexander Prokoshev <ap@insysnet.ru>
Organization: Information systems
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.10 and time drift
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

  after installation of 2.6.10 kernel I've noticed time drift, which
(according to ntpdc's dmpeer command) is about 10-15 seconds per hour.
Downgrade to 2.6.9 solves this problem. I can send any additional
information which may be helpful.

-- 
WBR, Alexander.
