Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbVINGSl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbVINGSl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 02:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbVINGSl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 02:18:41 -0400
Received: from 203-217-18-166.perm.iinet.net.au ([203.217.18.166]:60038 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S965038AbVINGSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 02:18:40 -0400
Message-ID: <4327C0EB.9040403@knobbits.org>
Date: Wed, 14 Sep 2005 16:19:23 +1000
From: "Michael (Micksa) Slade" <micksa@knobbits.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050820 Debian/1.7.11-0ubuntu2
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6 breaks my KVM?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an "intelligent" (but cheap) KVM which was working fine for me 
until I moved to a 2.6 linux kernel.

Not sure exactly where it started, but the issue happens with 2.6 
kernels (I've tried several) and not 2.4 kernels.

The mouse misbehaves.  touching the mouse causes the pointer to go 
haywire and jump everywhere, and there's the occasional button click too 
I think.

It happens with both my older logitech mouse and a newer MS 
intellimouse.  Both work fine with 2.6 when plugged in directly.

The keyboard is fine.

The same KVM works fine with windows ME and XP.

Anyone know what's causing this?

Mick.

