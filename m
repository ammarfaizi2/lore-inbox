Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVGHA5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVGHA5L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 20:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262398AbVGHA5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 20:57:11 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:49332 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S262390AbVGHA5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 20:57:10 -0400
From: Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>
Subject: Re: IBM HDAPS things are looking up (was: Re: [Hdaps-devel] Re: [ltp]  IBM HDAPS Someone interested? (Accelerometer))
To: Clemens Koller <clemens.koller@anagramm.de>, Jens Axboe <axboe@suse.de>,
       Lenz Grimmer <lenz@grimmer.com>, Arjan van de Ven <arjan@infradead.org>,
       Alejandro Bonilla <abonilla@linuxwireless.org>,
       Jesper Juhl <jesper.juhl@gmail.com>, Dave Hansen <dave@sr71.net>,
       hdaps-devel@lists.sourceforge.net,
       LKML List <linux-kernel@vger.kernel.org>
Reply-To: 7eggert@gmx.de
Date: Fri, 08 Jul 2005 02:56:08 +0200
References: <4msjB-DS-9@gated-at.bofh.it> <4mste-IL-1@gated-at.bofh.it> <4msME-SM-9@gated-at.bofh.it> <4msWl-Yq-5@gated-at.bofh.it> <4mtza-1vg-15@gated-at.bofh.it> <4mtII-1Ab-13@gated-at.bofh.it> <4mtSm-1FA-5@gated-at.bofh.it> <4mtSn-1FA-11@gated-at.bofh.it> <4mwx1-3N9-25@gated-at.bofh.it> <4mx9A-4qm-1@gated-at.bofh.it> <4nzCr-6fN-19@gated-at.bofh.it> <4nI36-527-9@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1DqhA2-000200-15@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Koller <clemens.koller@anagramm.de> wrote:

> Well, sure, it's not a notebook HDD, but maybe it's possible
> to give headpark a more generic way to get the heads parked?

I remember my old MFM HDD, which had a Landing Zone stored in the BIOS to
which the park command would seek. Maybe you could do something similar
and park the head on the last cylinder if the other options fail.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.
