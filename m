Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261431AbSIWWQk>; Mon, 23 Sep 2002 18:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261460AbSIWWQk>; Mon, 23 Sep 2002 18:16:40 -0400
Received: from dsl-213-023-022-250.arcor-ip.net ([213.23.22.250]:26295 "EHLO
	starship") by vger.kernel.org with ESMTP id <S261431AbSIWWQj>;
	Mon, 23 Sep 2002 18:16:39 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Dave Olien <dmo@osdl.org>
Subject: Re: DAC960 in 2.5.38, with new changes
Date: Tue, 24 Sep 2002 00:22:04 +0200
X-Mailer: KMail [version 1.3.2]
Cc: axboe@suse.de, _deepfire@mail.ru, linux-kernel@vger.kernel.org
References: <20020923120400.A15452@acpi.pdx.osdl.net> <E17tb9H-0003d7-00@starship> <20020923150302.A16033@acpi.pdx.osdl.net>
In-Reply-To: <20020923150302.A16033@acpi.pdx.osdl.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17tbaf-0003dC-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 September 2002 00:03, Dave Olien wrote:
> By the way, I don't know how extensive your code reviewing 
> of my changes has been.

Horribly unextensive.

> This morning I sent you the complete driver patch from 2.5.38
> to the latest version of the driver.  That contains all of
> the changes I sent you last week, plus new ones.
> 
> Would it be better for me to send you incremental patches
> in the future?  I could instead generate a patch relative to the
> previous version of the driver I sent you.

Far better to send the whole patch.  If anybody should be sending
incremental patches, it's me to you.

I have a number of code reading projects going at the moment, DAC960
is one of them.  Rather than read the whole think I'll just start
with your bio changes, because it's fairly central and also fairly
focussed, plus I need the incentive to go in and figure out just what
Jens, Suparna et al have done in there.

-- 
Daniel
