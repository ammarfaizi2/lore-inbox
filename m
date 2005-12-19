Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVLSSHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVLSSHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 13:07:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbVLSSHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 13:07:00 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:52418 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S932340AbVLSSHA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 13:07:00 -0500
Message-ID: <43A70877.DA99207@tv-sign.ru>
Date: Mon, 19 Dec 2005 22:22:31 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Steven Rostedt <rostedt@goodmis.org>,
       Daniel Walker <dwalker@mvista.com>
Subject: Re: [PATCH rc5-rt2 2/3] plist: add new implementation
References: <F989B1573A3A644BAB3920FBECA4D25A05050EF4@orsmsx407>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Perez-Gonzalez, Inaky" wrote:
> 
> >From: Oleg Nesterov
> >
> >New implementation. It is smaller, and in my opinion cleaner.
> >User-space test: http://www.tv-sign.ru/oleg/plist.tgz
>
> /me suggests adding documentation to the header file succintly
> explaining how it is implemented and a quick usage guide (along
> with (C) info).

Ok, I'll try to steal some doc bits from current header and send
as a separate patch. Can't do it before Friday, sorry.

Oleg.
