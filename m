Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263268AbTDULAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 07:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263303AbTDULAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 07:00:46 -0400
Received: from 205-158-62-136.outblaze.com ([205.158.62.136]:44471 "HELO
	fs5-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id S263268AbTDULAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 07:00:45 -0400
Subject: Re: 2.5.68 comments
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: vlad@geekizoid.com
Cc: "'linux-kernel'" <linux-kernel@vger.kernel.org>
In-Reply-To: <001901c307c8$c2a8c580$0200a8c0@wsl3>
References: <001901c307c8$c2a8c580$0200a8c0@wsl3>
Content-Type: text/plain
Organization: 
Message-Id: <1050923559.607.16.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 (1.2.3-1) 
Date: 21 Apr 2003 13:12:39 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-21 at 07:42, Vlad@geekizoid.com wrote:
> And,
>   Can anyone tell me when 'make modules' and 'make modules_install' is going
> to work again?

It's been working for a very long time... Have you the latest modutils
from Rusty Rusell? The module format and loader changed at 2.5.48 (if I
remember correctly). If you use an older modutils, you'll get a lot of
errors when doing "make modules_install".

You can download modutils from
ftp://ftp.kernel.org/pub/linux/kernel/people/rusty/modules
-- 
Please AVOID sending me WORD, EXCEL or POWERPOINT attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html
Linux Registered User #287198

