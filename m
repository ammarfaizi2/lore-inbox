Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264075AbTH1N6O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:58:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264030AbTH1N6O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:58:14 -0400
Received: from mail2-216.ewetel.de ([212.6.122.116]:45215 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S264075AbTH1N6M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:58:12 -0400
Date: Thu, 28 Aug 2003 15:57:40 +0200 (CEST)
From: Pascal Schmidt <der.eremit@email.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
cc: Andrew Morton <akpm@osdl.org>,
       "Marcelo W. Tosatti" <marcelo@conectiva.com.br>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4.22-rc1] ext3/jbd assertion failure transaction.c:1164
In-Reply-To: <1062069306.17230.117.camel@sisko.scot.redhat.com>
Message-ID: <Pine.LNX.4.44.0308281555540.1044-100000@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Aug 2003, Stephen C. Tweedie wrote:

> Many thanks --- I was able to reproduce this very easily, and I know of
> one or two very unusual things that fsx does which might well be the
> trigger here.  I'll let you know how things go.

Good, at least it's not a bug that only happens here and is hard to
reproduce elsewhere.

I hope this does not happen under normal fs usage. ;)

-- 
Ciao,
Pascal

