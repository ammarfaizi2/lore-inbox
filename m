Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265782AbUGDVSZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265782AbUGDVSZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 17:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265785AbUGDVSZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 17:18:25 -0400
Received: from news.cistron.nl ([62.216.30.38]:20170 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S265782AbUGDVSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 17:18:24 -0400
From: dth@ncc1701.cistron.net (Danny ter Haar)
Subject: Re: [PATCH,RFT] SATA interrupt handling
Date: Sun, 4 Jul 2004 21:18:23 +0000 (UTC)
Organization: Cistron
Message-ID: <cc9s6v$bnm$1@news.cistron.nl>
References: <40E77352.5090703@pobox.com>
X-Trace: ncc1701.cistron.net 1088975903 12022 62.216.30.38 (4 Jul 2004 21:18:23 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: dth@ncc1701.cistron.net (Danny ter Haar)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik  <jgarzik@pobox.com> wrote:
>Attached is the latest SATA patch (and BK info).

2.6.7-bk17 & your patches works fine on the ICH5
which had problems with kernels above -bk6 (unless 
i used acpi=off).

Thanks!

Danny
-- 
"If Microsoft had been the innovative company that it calls itself, it 
would have taken the opportunity to take a radical leap beyond the Mac, 
instead of producing a feeble, me-too implementation." - Douglas Adams -

