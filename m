Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbTAPN5z>; Thu, 16 Jan 2003 08:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267091AbTAPN5z>; Thu, 16 Jan 2003 08:57:55 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:40715 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP
	id <S267090AbTAPN5y>; Thu, 16 Jan 2003 08:57:54 -0500
Date: Thu, 16 Jan 2003 15:06:47 +0100 (CET)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux Geek <bourne@ToughGuy.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Tar'ing /proc ???
In-Reply-To: <Pine.LNX.3.95.1030116090109.4226A-100000@chaos.analogic.com>
Message-ID: <Pine.LNX.4.51.0301161505570.20335@dns.toxicfilms.tv>
References: <Pine.LNX.3.95.1030116090109.4226A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Normally, you do `tar -clf`
>                         |________ stay on the same file-system.
> Otherwise toy need to use --exclude /proc.  Proc is a virtual
> file-system that contains things like kcore. You can get into
Well i think that besides kcore (and maybe kmem) you should be able
to archive it.

Regards,
Maciej Soltysiak

