Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbVGYRfA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbVGYRfA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 13:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVGYRfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 13:35:00 -0400
Received: from smtp3.brturbo.com.br ([200.199.201.164]:60388 "EHLO
	smtp3.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261396AbVGYRe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 13:34:59 -0400
Message-ID: <42E522B4.2080000@brturbo.com.br>
Date: Mon, 25 Jul 2005 14:34:44 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: ncunningham@cyclades.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add missing tvaudio try_to_freeze.
References: <1121659791.13487.74.camel@localhost>
In-Reply-To: <1121659791.13487.74.camel@localhost>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel,

Nigel Cunningham wrote:
> Hi.
> 
> The .c gives Gerd Knorr as the maintainer of this file, but no email
> address. The MAINTAINERS file doesn't have his name or make it clear who
> owns the file. I haven't therefore been able to cc the maintainer.

	I'm current maintainer of V4L. The patch was tested and it looks ok.

> 
> Tvaudio lacks a refrigerator call. This patch fixes that.
> 
> Regards,
> 
> Nigel
> 
> Signed-off by: Nigel Cunningham <ncunningham@suspend2.net>
Signed-off-by: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
