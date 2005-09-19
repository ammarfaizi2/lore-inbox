Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932383AbVISJlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932383AbVISJlm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 05:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVISJlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 05:41:42 -0400
Received: from ns.firmix.at ([62.141.48.66]:17798 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S932383AbVISJll (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 05:41:41 -0400
Subject: Re: [Patch] Support UTF-8 scripts
From: Bernd Petrovitsch <bernd@firmix.at>
To: Valdis.Kletnieks@vt.edu
Cc: "\"Martin v." =?ISO-8859-1?Q?L=F6wis=22?= <martin@v.loewis.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200509190900.j8J90lXx001654@turing-police.cc.vt.edu>
References: <4Nvab-7o5-11@gated-at.bofh.it> <4Nvab-7o5-13@gated-at.bofh.it>
	 <4Nvab-7o5-15@gated-at.bofh.it> <4Nvab-7o5-17@gated-at.bofh.it>
	 <4Nvab-7o5-19@gated-at.bofh.it> <4Nvab-7o5-21@gated-at.bofh.it>
	 <4Nvab-7o5-23@gated-at.bofh.it> <4Nvab-7o5-25@gated-at.bofh.it>
	 <4Nvab-7o5-27@gated-at.bofh.it> <4NvjM-7CU-7@gated-at.bofh.it>
	 <4NvjM-7CU-5@gated-at.bofh.it> <4NxbR-20S-1@gated-at.bofh.it>
	 <4NEn7-3M5-7@gated-at.bofh.it> <4NTvO-yJ-13@gated-at.bofh.it>
	 <4O1MJ-3Hf-5@gated-at.bofh.it> <4O8Oh-5jp-7@gated-at.bofh.it>
	 <432E448D.2080402@v.loewis.de> <1127118382.1080.19.camel@tara.firmix.at>
	 <200509190900.j8J90lXx001654@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: Firmix Software GmbH
Date: Mon, 19 Sep 2005 11:41:30 +0200
Message-Id: <1127122891.1080.32.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-19 at 05:00 -0400, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 19 Sep 2005 10:26:22 +0200, Bernd Petrovitsch said:
> 
> > We will see how it develops. Actually the marker could be used to detect
> > endianness of the file if I read below URL correctly ....
> 
> Text files have endianness????

Unicode-16 ones with 16 bit per character (as in Win NT), yes.
UTF-8 ones not AFAIK.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

