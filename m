Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266675AbSLWHGe>; Mon, 23 Dec 2002 02:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266676AbSLWHGe>; Mon, 23 Dec 2002 02:06:34 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:41446
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id <S266675AbSLWHGd>; Mon, 23 Dec 2002 02:06:33 -0500
Message-ID: <3E06B7D7.6000004@redhat.com>
Date: Sun, 22 Dec 2002 23:14:31 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20021221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>, Ingo Molnar <mingo@elte.hu>,
       bart@etpmod.phys.tue.nl, davej@codemonkey.org.uk, hpa@transmeta.com,
       terje.eggestad@scali.com, matti.aarnio@zmailer.org, hugh@veritas.com,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212222050030.1217-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0212222050030.1217-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> How does the attached patch work for people?

I've compiled glibc and ran the test suite without any problems.

-- 
--------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------

