Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263955AbTJ1M6F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 07:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263959AbTJ1M6F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 07:58:05 -0500
Received: from hq.pm.waw.pl ([195.116.170.10]:19371 "EHLO hq.pm.waw.pl")
	by vger.kernel.org with ESMTP id S263955AbTJ1M6D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 07:58:03 -0500
To: Pavel Machek <pavel@ucw.cz>
Cc: Jeff Garzik <jgarzik@pobox.com>, Hans Reiser <reiser@namesys.com>,
       "Mudama, Eric" <eric_mudama@Maxtor.com>,
       "'Norman Diamond'" <ndiamond@wta.att.ne.jp>,
       "'Wes Janzen '" <superchkn@sbcglobal.net>,
       "'Rogier Wolff '" <R.E.Wolff@BitWizard.nl>,
       "'John Bradford '" <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, "'Justin Cormack '" <justin@street-vision.com>,
       "'Vitaly Fertman '" <vitaly@namesys.com>
Subject: Re: Blockbusting news, results get worse
References: <785F348679A4D5119A0C009027DE33C105CDB3B0@mcoexc04.mlm.maxtor.com>
	<3F9D6891.5040300@namesys.com> <3F9D7666.6010504@pobox.com>
	<20031028012143.GA427@elf.ucw.cz>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: 28 Oct 2003 13:54:33 +0100
In-Reply-To: <20031028012143.GA427@elf.ucw.cz>
Message-ID: <m37k2pfrp2.fsf@defiant.pm.waw.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

> Well, even without FLUSH CACHE, you can expect that sector being
> writen during powerfail either contains old data *or* new data.

I thinks so. It was not always the case with IBM DTLA drives, though.
-- 
Krzysztof Halasa, B*FH
