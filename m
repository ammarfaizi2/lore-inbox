Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265568AbSLDJ6o>; Wed, 4 Dec 2002 04:58:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266298AbSLDJ6o>; Wed, 4 Dec 2002 04:58:44 -0500
Received: from ns.suse.de ([213.95.15.193]:10509 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265568AbSLDJ6o>;
	Wed, 4 Dec 2002 04:58:44 -0500
To: "Folkert van Heusden" <folkert@vanheusden.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.20] problem with updating time fields?
References: <003c01c29a4a$82bdcf10$3640a8c0@boemboem>
X-Yow: Why is everything made of Lycra Spandex?
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 03 Dec 2002 13:40:07 +0100
In-Reply-To: <003c01c29a4a$82bdcf10$3640a8c0@boemboem> ("Folkert van
 Heusden"'s message of "Mon, 2 Dec 2002 22:33:52 +0100")
Message-ID: <jeadjnnumw.fsf@sykes.suse.de>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.3.50 (ia64-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Folkert van Heusden" <folkert@vanheusden.com> writes:

|> |> Bug? Or am I ignorant?
|> A> Check out the timezone.
|> 
|> Not set, as far as I can see: date says they're both in
|> CET (central european time?).

But your ftp server obviously uses a different time zone.  Probably it
just uses UTC because it does not know better.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Deutschherrnstr. 15-19, D-90429 Nürnberg
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
