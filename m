Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbTESOx5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 10:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262494AbTESOx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 10:53:57 -0400
Received: from pub237.cambridge.redhat.com ([213.86.99.237]:30162 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id S262488AbTESOx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 10:53:56 -0400
Subject: Re: [PATCH] Shared crc32 for 2.4.
From: David Woodhouse <dwmw2@infradead.org>
To: Duncan Sands <baldrick@wanadoo.fr>
Cc: marcelo@conectiva.com.br, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <200305190924.53700.baldrick@wanadoo.fr>
References: <1053193432.9218.13.camel@imladris.demon.co.uk>
	 <200305190924.53700.baldrick@wanadoo.fr>
Content-Type: text/plain
Organization: 
Message-Id: <1053356809.20074.48.camel@passion.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5.dwmw2) 
Date: Mon, 19 May 2003 16:06:50 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-19 at 08:24, Duncan Sands wrote:
> --- linux-2.4/Documentation/Configure.help.orig	2003-05-16 16:15:52.000000000 +0200
> +++ linux-2.4/Documentation/Configure.help	2003-05-19 09:23:08.000000000 +0200

Thanks; added to the BK tree which Marcelo was asked to pull from, and
I'm sure Alan has picked it up for himself.

-- 
dwmw2

