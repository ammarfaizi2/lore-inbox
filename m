Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266460AbUI0P0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266460AbUI0P0a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUI0P0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:26:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:9168 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266460AbUI0PZU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:25:20 -0400
Message-ID: <415830D2.6030203@suse.de>
Date: Mon, 27 Sep 2004 17:25:06 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@novell.com>
Cc: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Chris Wright <chrisw@osdl.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>,
       Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: mlock(1)
References: <E1CAzyM-0008DI-00@calista.eckenfels.6bone.ka-ip.net> <1096071873.3591.54.camel@desktop.cunninghams> <20040925011800.GB3309@dualathlon.random> <4157B04B.2000306@suse.de> <20040927141652.GF28865@dualathlon.random> <4158250E.9020005@suse.de> <20040927150702.GI28865@dualathlon.random>
In-Reply-To: <20040927150702.GI28865@dualathlon.random>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Mon, Sep 27, 2004 at 04:34:54PM +0200, Stefan Seyfried wrote:

> Your "close-lid with suspend-to-disk" without ever asking password in
> suspend is fundamentally unfixable, unless you use public key

or unless i enter it on every boot.

> Probably the next best thing you can do is to ask a preventive suspend
> password during boot, for the suspend-capable-machines. That would be
> more reasonable since I'd leave it disabled on my desktop.

or just enter the cryptoswap password on every boot / resume :-)
-- 
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX AG Nürnberg.

"Any ideas, John?"
"Well, surrounding them's out."
