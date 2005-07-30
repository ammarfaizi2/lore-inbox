Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263102AbVG3S71@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263102AbVG3S71 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Jul 2005 14:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbVG3S71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Jul 2005 14:59:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27275 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263102AbVG3S7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Jul 2005 14:59:25 -0400
Date: Sat, 30 Jul 2005 19:59:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add -Werror-implicit-function-declaration to CFLAGS
Message-ID: <20050730185911.GA5481@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050730165202.GI5590@stusta.de> <20050730185226.GA9334@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050730185226.GA9334@mars.ravnborg.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2005 at 08:52:26PM +0200, Sam Ravnborg wrote:
> Please - use tabs for indention, not for alignment.
> The below would look rather messy with tabs=4.
> Almost everywhere tabs are used in Makefiles it is plina wrong.
> Tabs are brillient for indention but you cannot just assume 8 spaces = a
> tab. Not even at the beginning of the line.

as far as working on the kernel, yes you can assume that.

