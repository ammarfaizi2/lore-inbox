Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267918AbSIRRik>; Wed, 18 Sep 2002 13:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267890AbSIRRij>; Wed, 18 Sep 2002 13:38:39 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:46841 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S267883AbSIRRic>; Wed, 18 Sep 2002 13:38:32 -0400
Date: Wed, 18 Sep 2002 13:51:42 -0400 (EDT)
From: Rob Ransbottom <rir@attbi.com>
To: Sam Ravnborg <sam@ravnborg.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Clumsey make, README
In-Reply-To: <20020918174755.B1386@mars.ravnborg.org>
Message-ID: <Pine.LNX.3.96.1020918132657.21270C-100000@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, Sam Ravnborg wrote:

> On Wed, Sep 18, 2002 at 10:22:47AM -0400, Rob Ransbottom wrote:

> You can do:
> make allmodconfig
> make

My idea was that if this didn't use the .config file
it would be very convenient for naive users.
They could "make all_modules; make modules_install; "and
not disrupt their kernel config.

> make help
> Only kernel 2.5..

Thanks, I am currently moving to 2.4.
It is nice to look forward to something.

rob                     Live the dream.

