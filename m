Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266064AbUAQQBY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 11:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266066AbUAQQBY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 11:01:24 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:20237 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S266064AbUAQQBX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 11:01:23 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Sporadically now dial-up on 2.6.1 and 2.6.1-mm3
Date: Sat, 17 Jan 2004 19:00:29 +0300
User-Agent: KMail/1.5.3
Cc: Andrew Morton <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401171900.29894.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This was OK in 2.6.0. After updating to 2.6.1 I can dial into provider, I am 
authenticated and interfaces set up but apparently no packet ever flows over 
this connection. Same in 2.6.1-mm3. Sometimes (very rarely) it works but now 
I have to boot into 2.6.0 to send this.

There was similar problem somewhere around 2.5.70; I do not know specific fix 
as it went away after updating kernel version.

Please let me know what information is needed and how to collect it (I have 
close to zero knowledge about networking in kernel)

TIA

-andrey

