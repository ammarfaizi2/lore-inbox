Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262565AbVFVWc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262565AbVFVWc4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 18:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVFVWaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 18:30:52 -0400
Received: from webmail.topspin.com ([12.162.17.3]:54448 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262460AbVFVW1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 18:27:33 -0400
To: David Masover <ninja@slaphack.com>
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       =?UTF-8?B?TWFya3VzIFTQlnJu?==?UTF-8?B?cXZpc3Q=?= <mjt@nysv.org>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, hch@infradead.org, jgarzik@pobox.com,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
X-Message-Flag: Warning: May contain useful information
References: <200506221733.j5MHXEoH007541@laptop11.inf.utfsm.cl>
	<42B9DD48.6060601@slaphack.com>
From: Roland Dreier <roland@topspin.com>
Date: Wed, 22 Jun 2005 15:27:26 -0700
In-Reply-To: <42B9DD48.6060601@slaphack.com> (David Masover's message of
 "Wed, 22 Jun 2005 16:51:04 -0500")
Message-ID: <52psueowmp.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Jun 2005 22:27:26.0639 (UTC) FILETIME=[91899BF0:01C57779]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> Spotlight on the Mac.  Users love it.  We can do it.  But
    David> not without changing something in the filesystem.

    David> Actually, I think we came up with several ways to do this,
    David> all of which required Reiser4 interfaces.

It seems the existing Beagle project is a counterexample to this.  In
fact, to make things even more perfect, Beagle doesn't work on top of
Reiser4.

 - R.
