Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbTINHXh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 03:23:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262323AbTINHXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 03:23:37 -0400
Received: from keetweej.xs4all.nl ([213.84.46.114]:2244 "EHLO
	keetweej.vanheusden.com") by vger.kernel.org with ESMTP
	id S262319AbTINHXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 03:23:36 -0400
From: Folkert van Heusden <folkert@vanheusden.com>
Reply-To: folkert@vanheusden.com
Organization: vanheusdendotcom
To: Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org
Subject: Re: logging when SIGSEGV is processed?
Date: Sun, 14 Sep 2003 09:23:34 +0200
User-Agent: KMail/1.5.3
References: <200309140328.54920.folkert@vanheusden.com> <20030914021829.GA9117@triplehelix.org>
In-Reply-To: <20030914021829.GA9117@triplehelix.org>
WebSite: http://www.vanheusden.com/
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309140923.34273.folkert@vanheusden.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 14 September 2003 04:18, Joshua Kwan wrote:
> On Sun, Sep 14, 2003 at 03:28:54AM +0200, Folkert van Heusden wrote:
> > I found this patch for kernel 2.2 which logs a message when some process
> > receives SIGSEGV. Imho something very usefull: I could create some script
> > which sends an e-mail if some critical (apache, mysql, etc.) process
> > segfaults. I was wondering: has anyone ported this patch to 2.4 or 2.6?
>
> What patch?

http://www.kyuzz.org/antirez/sigsegv/


Folkert van Heusden

+--------------------------------------------------------------------------+
| UNIX sysop? Then give MultiTail ( http://www.vanheusden.com/multitail/ ) |
| a try, it brings monitoring logfiles (and such) to a different level!    |
+---------------------------------------------------= www.vanheusden.com =-+

