Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272162AbTHNFFR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 01:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272163AbTHNFFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 01:05:16 -0400
Received: from f16.mail.ru ([194.67.57.46]:35858 "EHLO f16.mail.ru")
	by vger.kernel.org with ESMTP id S272162AbTHNFFN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 01:05:13 -0400
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: =?koi8-r?Q?=22?=Andrew Morton=?koi8-r?Q?=22=20?= <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: new dev_t printable convention and lilo
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Thu, 14 Aug 2003 09:05:02 +0400
In-Reply-To: <20030813132408.4c232ae5.akpm@osdl.org>
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E19nAII-000Oi9-00.arvidjaar-mail-ru@f16.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



[...]
> > it means handle-old-dev_t is meaningless and has to be removed ; and if we want people to use new format, it needs to go into name_to_dev_t.
> 
> It's better to handle both isn't it?
> 

is /sys/block/<name>/dev ever going to be in old format except if
due to a bug?

