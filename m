Return-Path: <linux-kernel-owner+w=401wt.eu-S1751194AbXAPTmh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbXAPTmh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 14:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbXAPTmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 14:42:37 -0500
Received: from mail.parknet.jp ([210.171.160.80]:1767 "EHLO parknet.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751194AbXAPTmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 14:42:36 -0500
X-AuthUser: hirofumi@parknet.jp
To: Olivier Galibert <galibert@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@linux.intel.com>,
       Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] MMCONFIG: Reject a broken MCFG tables on Asus etc
References: <87hcuusjm1.fsf@duaron.myhome.or.jp>
	<20070116191902.GA4192@dspnet.fr.eu.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 17 Jan 2007 04:42:24 +0900
In-Reply-To: <20070116191902.GA4192@dspnet.fr.eu.org> (Olivier Galibert's message of "Tue\, 16 Jan 2007 20\:19\:02 +0100")
Message-ID: <8764b6g3mn.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Galibert <galibert@pobox.com> writes:

> If you're going to do a MCFG validation function, and I don't have a
> problem with that, you should put the e820 test in it too.

Sounds good, thanks. I'll do later.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
