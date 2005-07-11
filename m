Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262440AbVGKTZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262440AbVGKTZl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 15:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262413AbVGKTIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 15:08:42 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:5582 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262472AbVGKTHO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 15:07:14 -0400
Message-ID: <42D2C358.2010403@namesys.com>
Date: Mon, 11 Jul 2005 12:07:04 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Crilly <jim@why.dont.jablowme.net>
CC: Ed Tomlinson <tomlins@cam.org>, Ed Cogburn <edcogburn@hotpop.com>,
       linux-kernel@vger.kernel.org
Subject: Re: reiser4 vs politics: linux misses out again
References: <200507100510.j6A5ATun010304@laptop11.inf.utfsm.cl> <20050710202129.GA3550@mail> <dascln$lq3$1@sea.gmane.org> <200507110709.47180.tomlins@cam.org> <20050711181646.GD17426@voodoo>
In-Reply-To: <20050711181646.GD17426@voodoo>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Crilly wrote:

>
>I thought r3 was journaled from the beginning; the Namesys site credits
>Chris with the addition of a relocated and large journal. And yes, a good
>bit of the patches were from him.
>

Chris and I disagree about QA methodology, but I am deeply in debt to
him for his contributions.  R3 did not have a journal at first, that was
his contribution, and a major part of what made reiserfs useful to real
users.

Hans
