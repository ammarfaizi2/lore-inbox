Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263776AbTJCSM0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 14:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263797AbTJCSM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 14:12:26 -0400
Received: from 218-bem-2.acn.waw.pl ([62.121.81.218]:56840 "EHLO
	woland.michal.waw.pl") by vger.kernel.org with ESMTP
	id S263776AbTJCSMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 14:12:25 -0400
Date: Fri, 3 Oct 2003 20:12:32 +0200
From: Michal Kochanowicz <michal@michal.waw.pl>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test6] definition and usage of __u64/__s64 inconsistent?
Message-ID: <20031003181232.GC4602@wieszak.lan>
References: <20031003085412.GA4602@wieszak.lan> <20031003020317.4d582970.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031003020317.4d582970.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Organization: Happy GNU/Linux Users
X-Signature-Tagline-Copyright: Piotr Zientarski, 1999-2001
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 03, 2003 at 02:03:17AM -0700, David S. Miller wrote:
> Not really.
> 
> We could fix this by using the __extension__ keyword and thereby
> get rid of the __STRICT_ANSI__ check and situations like your's
> would work.
OK, then question is: will you fix it? Or maybe it's application which
should be fixed (how?) ?
-- 
--= Michal Kochanowicz =--==--==BOFH==--==--= michal@michal.waw.pl =--
--= finger me for PGP public key or visit http://michal.waw.pl/PGP =--
--==--==--==--==--==-- Vodka. Connecting people.--==--==--==--==--==--
A chodzenie po górach SSIE!!!
