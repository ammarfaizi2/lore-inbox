Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbVE1FQx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbVE1FQx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 01:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVE1FQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 01:16:53 -0400
Received: from smtp1.sloane.cz ([62.240.161.228]:6616 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S261788AbVE1FQw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 01:16:52 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: problem with ALSA ane intel modem driver
Date: Sat, 28 May 2005 07:16:46 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505280716.46688.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

for testing purposes I compiled 2.6.12-rc5 and my dmesg si full of 

codec_semaphore: semaphore is not ready [0x1][0x701300]
codec_read 1: semaphore is not ready for register 0x54
codec_semaphore: semaphore is not ready [0x1][0x701300]
codec_write 1: semaphore is not ready for register 0x54
codec_semaphore: semaphore is not ready [0x1][0x700300]
codec_write 0: semaphore is not ready for register 0x2c

Michal
