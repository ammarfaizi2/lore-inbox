Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266481AbUIEKFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266481AbUIEKFd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Sep 2004 06:05:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266505AbUIEKFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Sep 2004 06:05:33 -0400
Received: from relay-av.club-internet.fr ([194.158.96.107]:41694 "EHLO
	relay-av.club-internet.fr") by vger.kernel.org with ESMTP
	id S266481AbUIEKF3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Sep 2004 06:05:29 -0400
From: Yapo Sebastien <sebastien.yapo@e-neyret.com>
Organization: e-Neyret
To: linux-kernel@vger.kernel.org
Subject: Re: Mouse Support in Kernel 2.6.8
Date: Sun, 5 Sep 2004 12:05:27 +0000
User-Agent: KMail/1.6.1
References: <20040905095313.42297.qmail@web8504.mail.in.yahoo.com>
In-Reply-To: <20040905095313.42297.qmail@web8504.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200409051205.27922.sebastien.yapo@e-neyret.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please guide me how to proceed to provide the mouse
> support in my kernel 2.6.8.
>

CONFIG_USB_HID=y
CONFIG_USB_HIDINPUT=y

Did you try that ?

Sebastien
