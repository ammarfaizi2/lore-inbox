Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263557AbTDDLDt (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 06:03:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263619AbTDDLDt (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 06:03:49 -0500
Received: from ariel.yandex.ru ([213.180.193.62]:4362 "EHLO ariel.yandex.ru")
	by vger.kernel.org with ESMTP id S263557AbTDDLDm (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 06:03:42 -0500
Date: Fri, 4 Apr 2003 15:14:55 +0400 (MSD)
From: "K-MailNet" <K-MailNet@yandex.ru>
Reply-To: K-MailNet@yandex.ru
Message-Id: <3E8D692F.000004.30743@ariel.yandex.ru>
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ]
To: linux-kernel@vger.kernel.org
Subject: question about buffer_head
X-source-ip: 195.201.254.225
Content-Type: text/plain;
  charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
Could anybody explain me what this list content

buffer_head->b_assoc_buffers

In the kenel's  coments is writen  /* associated with another mapping */
I can't  clearly understand it
Does it contents others buffer_heads of the page or thomething else?

Thanks

