Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965129AbWGFDHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965129AbWGFDHP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 23:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965143AbWGFDHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 23:07:15 -0400
Received: from mail1.bizmail.net.au ([202.162.77.164]:14532 "EHLO
	mail1.bizmail.net.au") by vger.kernel.org with ESMTP
	id S965129AbWGFDHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 23:07:14 -0400
Message-ID: <4960.58.105.227.226.1152155926.squirrel@58.105.227.226>
Date: Thu, 6 Jul 2006 13:18:46 +1000 (EST)
Subject: Re: O_TARGET
From: yh@bizmail.com.au
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The O_TARGET is no longer valid in kernel 2.4, what is the replacement of
following module object in kernel 2.6?

O_TARGET := NewSerial.o

obj-y   := new_s_driver.o queue.o
obj-m   := $(O_TARGET)

Thank you.

Jim


