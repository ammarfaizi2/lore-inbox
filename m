Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263178AbSJJA0G>; Wed, 9 Oct 2002 20:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263193AbSJJA0F>; Wed, 9 Oct 2002 20:26:05 -0400
Received: from relay1.pair.com ([209.68.1.20]:21263 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S263178AbSJJA0F>;
	Wed, 9 Oct 2002 20:26:05 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <3DA4CD07.5C0945B2@kegel.com>
Date: Wed, 09 Oct 2002 17:42:47 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-3custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: re: [PATCH 1/3] High-res-timers part 1 (core) take 5  
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My company needs the high-res-timers functionality, and
we and others are starting to port it to ppc for 2.4.
>From there it ought to be easy to drop the ppc specific part
into 2.5 -- assuming the generic part makes it into 2.5.
Anyone know how Linus feels about the patch?

- Dan
