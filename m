Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264386AbUFGKEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264386AbUFGKEK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 06:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264388AbUFGKEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 06:04:10 -0400
Received: from pD9FFA21B.dip.t-dialin.net ([217.255.162.27]:30610 "EHLO
	router.zodiac.dnsalias.org") by vger.kernel.org with ESMTP
	id S264386AbUFGKEI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 06:04:08 -0400
From: Alexander Gran <alex@zodiac.dnsalias.org>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: 2.6.7-rc2-mm1
Date: Wed, 2 Jun 2004 00:21:12 +0200
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
References: <20040601021539.413a7ad7.akpm@osdl.org> <20040601143622.0717e85b.akpm@osdl.org> <20040601143623.3ef8c164.davem@redhat.com>
In-Reply-To: <20040601143623.3ef8c164.davem@redhat.com>
X-Ignorant-User: yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406020021.12636@zodiac.zodiac.dnsalias.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 1. Juni 2004 23:36 schrieb David S. Miller:
> On Tue, 1 Jun 2004 14:36:22 -0700
>
> Andrew Morton <akpm@osdl.org> wrote:
> > Alexander Gran <alex@zodiac.dnsalias.org> wrote:
> > > I can neither enter nor activate the gigabit ethernet driver section in
> > > menuconfig
> >
> > I can, and nothing seems to have changed which would affect this.
>
> It seems you have to enable the 10/100 section in order to get to
> the gigabit section.  This is the case in the standard tree too,
> nothing in -mm changed this.

Ahh, all right. Than the bug was introduced with 2.6.7-rc2. 

regards
Alex

-- 
Encrypted Mails welcome.
PGP-Key at http://zodiac.dnsalias.org/misc/pgpkey.asc | Key-ID: 0x6D7DD291

