Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263178AbVFXGhO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbVFXGhO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 02:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263179AbVFXGhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 02:37:14 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:55207 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S263178AbVFXGhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 02:37:10 -0400
Message-ID: <42BBAA0F.2020404@namesys.com>
Date: Thu, 23 Jun 2005 23:37:03 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nikita Danilov <nikita@clusterfs.com>
CC: David Masover <ninja@slaphack.com>,
       "Artem B. Bityuckiy" <dedekind@yandex.ru>,
       =?UTF-8?B?TWFya3VzIFTQlnJucXZpc3Q=?= <mjt@nysv.org>,
       Christophe Saout <christophe@saout.de>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, jgarzik@pobox.com, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins
References: <200506221733.j5MHXEoH007541@laptop11.inf.utfsm.cl>	<42B9DD48.6060601@slaphack.com>	<17081.58619.671650.812286@gargle.gargle.HOWL>	<42BAC668.2030604@slaphack.com> <17083.14428.546772.353003@gargle.gargle.HOWL>
In-Reply-To: <17083.14428.546772.353003@gargle.gargle.HOWL>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikita, I respectfully disagree with what you say about the state of our
atomicity code.   It is not so far away as you describe, and probably 6
man weeks work could polish it off.  You don't see the value in what I
define as useful, namely atomicity without isolation.  Since you don't
see that, it is harder for you to see that something is close to working
and just needs 6 weeks of someone who groks what I am asking for.

Hans

