Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbVBXQDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVBXQDi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 11:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVBXP6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:58:50 -0500
Received: from [24.24.2.56] ([24.24.2.56]:18941 "EHLO ms-smtp-02.nyroc.rr.com")
	by vger.kernel.org with ESMTP id S262365AbVBXP5i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 10:57:38 -0500
Subject: Re: 2.6.11-rc5
From: Steven Rostedt <rostedt@goodmis.org>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: "M.Baris Demiray" <baris@labristeknoloji.com>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20050224183918.3f9de18a.vsu@altlinux.ru>
References: <Pine.LNX.4.58.0502232014190.18997@ppc970.osdl.org>
	 <20050224062908.GJ3163@waste.org> <421DCD44.1020504@tiscali.de>
	 <1109255111.1452.6.camel@localhost.localdomain>
	 <421DEB74.4060306@labristeknoloji.com>
	 <20050224183918.3f9de18a.vsu@altlinux.ru>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Thu, 24 Feb 2005 10:57:18 -0500
Message-Id: <1109260638.1452.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 18:39 +0300, Sergey Vlasov wrote:
> On Thu, 24 Feb 2005 16:57:56 +0200 M.Baris Demiray wrote:

> And especially at this chunk:
> 
> --- linux-2.6.11-rc4/Makefile 2005-02-23 20:53:50.707759849 -0800
> +++ linux-2.6.11-rc5/Makefile 2004-12-24 13:35:01.000000000 -0800
> @@ -1,7 +1,7 @@
> VERSION = 2
> PATCHLEVEL = 6
> -SUBLEVEL = 11
> -EXTRAVERSION =-rc4
> +SUBLEVEL = 10
> +EXTRAVERSION =
> NAME=Woozy Numbat
> # *DOCUMENTATION*
> 
> Obviously 2.6.11-rc5 is screwed up.

Yeah, but the linux-2.6.11-rc5.tar.bz2's Makefile has 

VERSION = 2
PATCHLEVEL = 6
SUBLEVEL = 11
EXTRAVERSION =-rc5
NAME=Woozy Numbat

-- Steve


