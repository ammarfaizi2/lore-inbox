Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSIDXww>; Wed, 4 Sep 2002 19:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSIDXwv>; Wed, 4 Sep 2002 19:52:51 -0400
Received: from [195.223.140.120] ([195.223.140.120]:40484 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316465AbSIDXwr>; Wed, 4 Sep 2002 19:52:47 -0400
Date: Thu, 5 Sep 2002 01:57:36 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Paolo Ciarrocchi <ciarrocchi@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BYTE Unix Benchmarks Version 3.6
Message-ID: <20020904235736.GD1238@dualathlon.random>
References: <20020904220055.21349.qmail@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020904220055.21349.qmail@linuxmail.org>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2002 at 06:00:55AM +0800, Paolo Ciarrocchi wrote:
> Hi all,
> I've just ran the BYTE Unix Benchmarks Version 3.6 on the 2.4.19 and on the 2.5.33 kernel.
> Here it goes the results:

can you make a run on 2.4.20pre5aa1 too? thanks,

> Comments?

I'm just guessing but I think part of the global regression in most
numbers is most due the increased HZ and rmap.

Andrea
