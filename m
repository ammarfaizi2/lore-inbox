Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbSKEXGO>; Tue, 5 Nov 2002 18:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265319AbSKEXGO>; Tue, 5 Nov 2002 18:06:14 -0500
Received: from 216-42-72-142.ppp.netsville.net ([216.42.72.142]:4525 "EHLO
	tiny.suse.com") by vger.kernel.org with ESMTP id <S265320AbSKEXGN> convert rfc822-to-8bit;
	Tue, 5 Nov 2002 18:06:13 -0500
Subject: Re: 2.5.46: SCSI and/or ReiserFS v3.6 broken? Kernel panic
From: Chris Mason <mason@suse.com>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <200211060006.10425.Dieter.Nuetzel@hamburg.de>
References: <200211060006.10425.Dieter.Nuetzel@hamburg.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Nov 2002 18:12:17 -0500
Message-Id: <1036537937.24354.337.camel@tiny>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 18:06, Dieter Nützel wrote:
> VFS: Cannot open root device "803" or 08:03
> Please append a correct "root=" boot option
> Kernel panic: VFS: unable to mount root fs on 08:03
> 
> With and without HugeTLB file system support.
> With and without ACPI, APIC.
> 
> Worked all the time before.

Is aic7xxx still in your config?  I'm using 2.5.45 here without
problems.

-chris


