Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269144AbUIBWTw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269144AbUIBWTw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 18:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269204AbUIBWR5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 18:17:57 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:60561 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S269161AbUIBWPH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 18:15:07 -0400
Date: Fri, 3 Sep 2004 00:17:33 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] kallsyms: speed up /proc/kallsyms
Message-ID: <20040902221733.GA8868@mars.ravnborg.org>
Mail-Followup-To: Paulo Marques <pmarques@grupopie.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
References: <4134DEF4.8090001@grupopie.com> <1094016277.17828.53.camel@bach> <4135AFBE.1000707@grupopie.com> <20040901192755.GC7219@mars.ravnborg.org> <41362694.9070101@grupopie.com> <20040901195132.GA15432@mars.ravnborg.org> <41370C7E.4020304@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41370C7E.4020304@grupopie.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 01:05:18PM +0100, Paulo Marques wrote:
 
> All 3 patches will be against 2.6.9-rc1-mm2. I'm just saying
> this to make sure I understood correctly what I'm supposed to
> do.

Preferable on top of Linus - latest.

	Sam
