Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264193AbTE0VlM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 17:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264196AbTE0VlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 17:41:11 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:31410 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264193AbTE0VlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 17:41:09 -0400
Date: Tue, 27 May 2003 18:52:24 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Pavel Roskin <proski@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VIA IDE fix for 2.4.21-rc5
In-Reply-To: <Pine.LNX.4.55.0305271735180.13016@marabou.research.att.com>
Message-ID: <Pine.LNX.4.55L.0305271851250.23144@freak.distro.conectiva>
References: <Pine.LNX.4.55.0305271735180.13016@marabou.research.att.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 May 2003, Pavel Roskin wrote:

> Hi, Marcelo!
>
> The last minute changes in 2.4.21-rc5 break VIA IDE compilation.  The
> patch is attached.  The ID and the relative position of the entry in the
> list have been taken from Linux 2.5.70.

Actually its via82cxxx audio driver, and its already fixed in bk.

Thanks
