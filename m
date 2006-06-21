Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWFUMzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWFUMzS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 08:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWFUMzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 08:55:07 -0400
Received: from web25810.mail.ukl.yahoo.com ([217.12.10.195]:30801 "HELO
	web25810.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S932096AbWFUMyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 08:54:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.fr;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=ts3b+yU4U1Prk4bGIZ8WS+6Yfm5I12sTIr3+fRwYggdIrP+q8D68UnPT6ttsk3HnfHUVosIUhiDwqHKH5D8y9D3hJj94z78XXdKQbQQZhhl4dOfp0r9g2E3HtQfl6gOkXOgR78+uVd3ZCXPTZuKsTQ5dKLMzC0qoasjuAfNIxJ8=  ;
Message-ID: <20060621125427.33238.qmail@web25810.mail.ukl.yahoo.com>
Date: Wed, 21 Jun 2006 12:54:27 +0000 (GMT)
From: moreau francis <francis_moreau2000@yahoo.fr>
Reply-To: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Sane value for MAX_ORDER used by buddy allocator
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on a home board which has only 32Mbytes for RAM. I'm
wondering if I should force MAX_ORDER value to 8. The default value
is 11 which seems too much for such a system with low mem...

If someone can give me some advices here.

thanks


