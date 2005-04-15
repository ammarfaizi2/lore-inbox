Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262642AbVDPDWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262642AbVDPDWy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 23:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbVDPDWx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 23:22:53 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:45979 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S262608AbVDPDW3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 23:22:29 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>
Subject: Re: [2.6 patch] drivers/video/intelfb/intelfbdrv.h
Date: Fri, 15 Apr 2005 12:52:06 +0800
User-Agent: KMail/1.5.4
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, Ingo Oeser <ioe-lkml@axxeo.de>
References: <20050415004849.GJ20400@stusta.de>
In-Reply-To: <20050415004849.GJ20400@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504151252.09918.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 April 2005 08:48, Adrian Bunk wrote:
> Ingo Oeser noticed that all that intelfbdrv.h contains are prototypes
> for static functions - and such prototypes don't belong into header
> files.
>
> This patch therefore removes drivers/video/intelfb/intelfbdrv.h and
> moves the prototypes to intelfbdrv.c .
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Patch is linewrapped.  Can you resend?

Tony


