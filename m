Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268918AbTBSOci>; Wed, 19 Feb 2003 09:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268917AbTBSOci>; Wed, 19 Feb 2003 09:32:38 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4612 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S268915AbTBSOci>; Wed, 19 Feb 2003 09:32:38 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200302191443.h1JEhvdm000194@81-2-122-30.bradfords.org.uk>
Subject: Re: Select voltage manually in cpufreq
To: cw@f00f.org (Chris Wedgwood)
Date: Wed, 19 Feb 2003 14:43:57 +0000 (GMT)
Cc: pavel@suse.cz, linux-kernel@vger.kernel.org, davej@suse.delinux@brodo.de
In-Reply-To: <20030218220858.GA15273@f00f.org> from "Chris Wedgwood" at Feb 18, 2003 02:08:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, and does slow-low-power mean 300MHz, 1.4V as bios said, or
> > 300MHz, 1.2V which is probably also safe?
> 
> I have no idea... that's the point... the user almost never knows what
> *exact* magic values are required, they just want fast-on-power or
> slow-on-battery sort of thing.
> 
> you pick two options, a slow and fast option; both should work

Until you are working on an embedded system, and want the extra
functionality.

Whenever you have a lot of options, adding extra options to try to
simplify things rarely achieves that.

Good defaults, and good documentation are much more useful than yet
another way to alter several variables at once.

John.
