Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTJ2HuO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Oct 2003 02:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbTJ2HuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Oct 2003 02:50:14 -0500
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43986 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S261909AbTJ2HuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Oct 2003 02:50:11 -0500
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="Big5"
MIME-Version: 1.0
X-Mailer: MIME::Lite 1.2  (F2.71; T1.001; A1.51; B2.12; Q2.03)
From: "CN" <cnliou9@fastmail.fm>
To: linux-kernel@vger.kernel.org
Date: Tue, 28 Oct 2003 23:50:10 -0800
X-Epoch: 1067413810
X-Sasl-enc: RHc0X2/tUdoMpz+9BNBKgQ
Subject: kernel: i8253 counting too high! resetting..
Message-Id: <20031029075010.596C57A6C6@smtp.us2.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I get several

kernel: i8253 counting too high! resetting..

entries in syslog from kernel 2.4.22 upgraded from Debian woody (gcc
2.95.4) running on AMD K6II 450MHz with 64MB RAM. I don't have such
problem in kernel 2.4.20 upgraded from Slackware (gcc 2.95.3) running on
another box with the identical CPU and main board (but with 192MB RAM).
Does this message hurt anything?

Regards,
CN

-- 
http://www.fastmail.fm - Faster than the air-speed velocity of an
                          unladen european swallow
