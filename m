Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268819AbUIHAiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268819AbUIHAiZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 20:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268817AbUIHAiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 20:38:24 -0400
Received: from smtp-out.hotpop.com ([38.113.3.51]:41933 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S268819AbUIHAiX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 20:38:23 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Adrian Bunk <bunk@fs.tum.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Linux-fbdev-devel] [patch] 2.6.9-rc1-mm4: atyfb_base.c gcc 2.95 compile error
Date: Wed, 8 Sep 2004 08:38:12 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org, geert@linux-m68k.org,
       linux-fbdev-devel@lists.sourceforge.net
References: <20040907020831.62390588.akpm@osdl.org> <20040907192616.GC2454@fs.tum.de>
In-Reply-To: <20040907192616.GC2454@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409080838.12496.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 September 2004 03:26, Adrian Bunk wrote:
> On Tue, Sep 07, 2004 at 02:08:31AM -0700, Andrew Morton wrote:
> >...
> > +fbdev-add-module_init-and-fb_get_options-per-driver.patch
> >
> >  fbdev update
> >...
>
> gcc 2.95 doesn't support code mixed with variable declarations:
>
> <--  snip  -->
>

My fault, I did not look more closely, thanks for the fix.

Tony


