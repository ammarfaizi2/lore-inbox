Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267508AbUJIWui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267508AbUJIWui (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 18:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267511AbUJIWui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 18:50:38 -0400
Received: from smtpq2.home.nl ([213.51.128.197]:483 "EHLO smtpq2.home.nl")
	by vger.kernel.org with ESMTP id S267508AbUJIWug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 18:50:36 -0400
Message-ID: <41686A40.3060305@keyaccess.nl>
Date: Sun, 10 Oct 2004 00:46:24 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Zaitsev <zzz@anda.ru>
CC: linux-kernel@vger.kernel.org
Subject: Re: [BUG][2.6.8.1] Something wrong with ISAPnP and serial driver
References: <20041010015206.A30047@natasha.ward.six> <4168479C.5080306@keyaccess.nl> <20041010033820.B30047@natasha.ward.six> <41685E04.3070103@keyaccess.nl> <20041010043443.A1639@natasha.ward.six>
In-Reply-To: <20041010043443.A1639@natasha.ward.six>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Zaitsev wrote:

> With the device ID added all the things just work.  Ok.  Thanks.  I'm
> sending the patch.

Good.

> /proc/tty/driver/serial shows the correct info for now.  Does the fact
> that it used to do not means that something wrong with sysfs PnP
> activation mechanics?

That would appear to be the case yes. Adam Belay <ambx1@neo.rr.com> is 
the person to talk to concerning PnP issues, if you care to.

Rene.


