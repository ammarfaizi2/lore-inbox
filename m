Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUJYAHs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUJYAHs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 20:07:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbUJYAHs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 20:07:48 -0400
Received: from 200-170-96-180.veloxmail.com.br ([200.170.96.180]:40608 "HELO
	qmail-out.veloxmail.com.br") by vger.kernel.org with SMTP
	id S261628AbUJYAHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 20:07:47 -0400
Date: Sun, 24 Oct 2004 21:07:41 -0300 (BRST)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <2@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Why bttv depends on FW_LOADER?
Message-ID: <Pine.LNX.4.61.0410242105530.3100@dyndns.pervalidus.net>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Vandrovec wrote:

> what is purpose of this change in 2.6.10-rc1?  I seem to have 
> no problems after removing dependency on FW_LOADER, and my 
> hardware definitely does not need any firmware to work.

And here I ended without bttv support, maybe because I didn't 
have FW_LOADER in .config ?

make oldconfig from a 2.6.9-rc4 .config to 2.6.10-rc1 just 
removed bttv support.

-- 
http://www.pervalidus.net/contact.html
