Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267926AbUHUVra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267926AbUHUVra (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 17:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267922AbUHUVr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 17:47:29 -0400
Received: from rproxy.gmail.com ([64.233.170.196]:59746 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S267926AbUHUVqy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 17:46:54 -0400
Message-ID: <2a4f155d04082114461d36ae1a@mail.gmail.com>
Date: Sun, 22 Aug 2004 00:46:54 +0300
From: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
Reply-To: =?ISO-8859-1?Q?ismail_d=F6nmez?= <ismail.donmez@gmail.com>
To: Christian Hesse <mail@earthworm.de>
Subject: Re: v2.6.8.1 breaks tspc
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200408212303.05143.mail@earthworm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <200408212303.05143.mail@earthworm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2004 23:02:58 +0200, Christian Hesse <mail@earthworm.de> wrote:
> Hello!
> 
> Kernel version 2.6.8.1 breaks tspc (Freenet6's Tunnel Server Protocol Client).
> It tries to connect to the server but waits forever. No problems with 2.6.7,
> booted the old kernel and it worked perfectly.
> 
> Any ideas?
> 

I can confirm the same problem here with 2.6.8.1-mm3 and 2.6.8.1

Cheers,
ismail

-- 
Time is what you make of it
