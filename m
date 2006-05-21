Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbWEUIfZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbWEUIfZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 04:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbWEUIfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 04:35:25 -0400
Received: from dd6424.kasserver.com ([85.13.131.51]:47521 "EHLO
	dd6424.kasserver.com") by vger.kernel.org with ESMTP
	id S1751507AbWEUIfZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 04:35:25 -0400
Message-ID: <44702650.30507@feuerpokemon.de>
Date: Sun, 21 May 2006 10:35:28 +0200
From: dragoran <dragoran@feuerpokemon.de>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: IA32 syscall 311 not implemented on x86_64
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I started to get such messages in dmesg:
IA32 syscall 311 from mozilla-xremote not implemented
IA32 syscall 311 from firefox-bin not implemented
IA32 syscall 311 from mplayer not implemented
what is syscall 311  and what effect does this have?
I am using 2.6.16-1.2111_FC5 (2.6.16.14)

