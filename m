Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267301AbUITT72@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267301AbUITT72 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 15:59:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266196AbUITT71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 15:59:27 -0400
Received: from smtp-out.hotpop.com ([38.113.3.61]:34438 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S267287AbUITT6m
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 15:58:42 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] fbdev broken in current bk for PPC
Date: Tue, 21 Sep 2004 03:59:21 +0800
User-Agent: KMail/1.5.4
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net
References: <1094783022.2667.106.camel@gaston> <20040920085214.0abe33a0.akpm@osdl.org> <200409210338.00863.adaplas@hotpop.com>
In-Reply-To: <200409210338.00863.adaplas@hotpop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200409210359.21424.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 21 September 2004 03:38, Antonino A. Daplas wrote:

> > fbdev-arrange-driver-order-in-makefile.patch

BTW, you may get rejects with the above patch as it depends on this.

fbdev-initialize-i810fb-after-agpgart.patch

Tony


