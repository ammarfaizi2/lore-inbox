Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVJQGRY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVJQGRY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 02:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVJQGRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 02:17:24 -0400
Received: from smtp103.sbc.mail.mud.yahoo.com ([68.142.198.202]:30127 "HELO
	smtp103.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751125AbVJQGRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 02:17:23 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 6/6] char, isicom: More whitespaces and coding style
Date: Mon, 17 Oct 2005 01:17:20 -0500
User-Agent: KMail/1.8.2
Cc: "Jiri Slaby" <xslaby@fi.muni.cz>, Andrew Morton <akpm@osdl.org>
References: <20051016222734.375FD22B371@anxur.fi.muni.cz>
In-Reply-To: <20051016222734.375FD22B371@anxur.fi.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510170117.21429.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 16 October 2005 17:27, Jiri Slaby wrote:

> +					wrd |= (port->xmit_buf[port->xmit_tail]
> +									<< 8);

> +						pr_dbg("interrupt: DCD->low.\n"
> +							);

> +		port->xmit_head = (port->xmit_head + cnt) & (SERIAL_XMIT_SIZE
> +			- 1);

You must be kidding...

-- 
Dmitry
