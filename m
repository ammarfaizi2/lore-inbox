Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267291AbTAVDv2>; Tue, 21 Jan 2003 22:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267299AbTAVDv2>; Tue, 21 Jan 2003 22:51:28 -0500
Received: from [65.39.167.210] ([65.39.167.210]:15368 "HELO innerfire.net")
	by vger.kernel.org with SMTP id <S267291AbTAVDv1>;
	Tue, 21 Jan 2003 22:51:27 -0500
Date: Tue, 21 Jan 2003 23:00:33 -0500 (EST)
From: Gerhard Mack <gmack@innerfire.net>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: why isn't quota dependant on ext2?
In-Reply-To: <20030121185927.3abd9298.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0301212259270.5687-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003, Andrew Morton wrote:

> Gerhard Mack <gmack@innerfire.net> wrote:
> >
> > Anyone know why the quota menu option isn't dependant on ext2 since that's
> > all it works with?
> >
>
> ext3, ufs and udf also use the core quota code.

The documentation says it only works with ext2 where would I find working
utilities to get it working on ext3 ?

	Gerhard


--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

