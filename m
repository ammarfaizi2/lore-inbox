Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbUL0TzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbUL0TzS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 14:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261970AbUL0TxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 14:53:11 -0500
Received: from mail.aknet.ru ([217.67.122.194]:52749 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S261961AbUL0Tve (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 14:51:34 -0500
Message-ID: <41D067AD.90607@aknet.ru>
Date: Mon, 27 Dec 2004 22:51:09 +0300
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: ru, en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: bug: cd-rom autoclose no longer works in 2.6.9/2.6.10
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Paul Ionescu wrote:
> Does 
> cat /proc/sys/dev/cdrom/autoclose
> return 1 or 0 ?
[skip]
>>/ $ cat /proc/sys/dev/cdrom/autoclose/
>>/ 1/
As explicitly written in my original
post, it returns 1. And CD-ROM is capable
of doing close either.

