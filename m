Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030429AbWGIATE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWGIATE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 20:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030430AbWGIATD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 20:19:03 -0400
Received: from beauty.rexursive.com ([203.171.74.242]:43705 "EHLO
	beauty.rexursive.com") by vger.kernel.org with ESMTP
	id S1030429AbWGIATB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 20:19:01 -0400
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
From: Bojan Smojver <bojan@rexursive.com>
To: Pavel Machek <pavel@suse.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Arjan van de Ven <arjan@infradead.org>,
       Sunil Kumar <devsku@gmail.com>, Avuton Olrich <avuton@gmail.com>,
       Olivier Galibert <galibert@pobox.com>, Jan Rychter <jan@rychter.com>,
       linux-kernel@vger.kernel.org, suspend2-devel@lists.suspend2.net,
       grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
In-Reply-To: <20060708235336.GF2546@elf.ucw.cz>
References: <20060627133321.GB3019@elf.ucw.cz>
	 <ce9ef0d90607080942w685a6b60q7611278856c78ac0@mail.gmail.com>
	 <1152377434.3120.69.camel@laptopd505.fenrus.org>
	 <200607082125.12819.rjw@sisk.pl>
	 <1152402366.2584.10.camel@coyote.rexursive.com>
	 <20060708235336.GF2546@elf.ucw.cz>
Content-Type: text/plain
Date: Sun, 09 Jul 2006 10:18:58 +1000
Message-Id: <1152404338.2584.14.camel@coyote.rexursive.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-07-09 at 01:53 +0200, Pavel Machek wrote:

> swsusp/uswsusp share 75% or so of code, and we can't really drop
> swsusp soon, because that would break existing setups. Warning
> year-or-so ahead is needed to do such big changes. Plus you are quite
> right n that "heavy to setup" thing.

Ah, right. Thanks for clearing that up.

So, the plan is that in about a year or so there won't be any completely
in-kernel suspend implementations, only uswsusp?

-- 
Bojan

