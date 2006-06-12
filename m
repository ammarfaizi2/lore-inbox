Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932585AbWFLWHj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932585AbWFLWHj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 18:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932580AbWFLWHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 18:07:39 -0400
Received: from xenotime.net ([66.160.160.81]:11671 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932575AbWFLWHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 18:07:38 -0400
Date: Mon, 12 Jun 2006 15:10:23 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Tim Bird <tim.bird@am.sony.com>
Cc: mpm@selenic.com, hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 built-in command line
Message-Id: <20060612151023.098c3956.rdunlap@xenotime.net>
In-Reply-To: <448DE3FF.5030304@am.sony.com>
References: <20060612144505.ee4788f0.rdunlap@xenotime.net>
	<448DE3FF.5030304@am.sony.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.5 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jun 2006 15:00:31 -0700 Tim Bird wrote:

> Randy.Dunlap wrote:
> > I frequently override command line options.  I guess I have no
> > use for this patch.
> 
> Randy,
> 
> Do you override the complete command line or individual boot args?
> On what platform(s)?

I probably should say I "append" to the command line instead of
"override" it.
On i386 and x86_64.

> Thanks - just trying to learn other people's situations...

---
~Randy
