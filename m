Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263585AbUDGUOO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 16:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264124AbUDGUON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 16:14:13 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:37470 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S263585AbUDGUOM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 16:14:12 -0400
Date: Wed, 7 Apr 2004 15:14:12 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
Message-ID: <20040407201412.GA23519@hexapodia.org>
References: <20040406220358.GE4828@hexapodia.org> <20040406173326.0fbb9d7a.akpm@osdl.org> <20040407173116.GB2814@hexapodia.org> <c51jql$7j4$2@news.cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c51jql$7j4$2@news.cistron.nl>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 07:12:21PM +0000, Miquel van Smoorenburg wrote:
> In article <20040407173116.GB2814@hexapodia.org>,
> Andy Isaacson  <adi@hexapodia.org> wrote:
> >The next feature to add would be OpenBSD-style "KB/s" reporting.  I'm
> >not going there.
> >
> >diff -ur coreutils-5.0.91/doc/coreutils.texi
> >coreutils-5.0.91-adi/doc/coreutils.texi
> 
> Doesn't it already do that ?
> 
> $ dd if=/dev/zero of=/tmp/file bs=4K count=100
> 100+0 records in
> 100+0 records out
> 409600 bytes transferred in 0.005108 seconds (80189583 bytes/sec)

hmmm...

debian/patches/05_dd-performance-counter.patch

Not upstream.

-andy
