Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964848AbVIMXnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964848AbVIMXnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 19:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVIMXnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 19:43:43 -0400
Received: from xenotime.net ([66.160.160.81]:64186 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751107AbVIMXnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 19:43:43 -0400
Date: Tue, 13 Sep 2005 16:43:39 -0700 (PDT)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: Sasha Khapyorsky <sashak@smlink.com>
cc: Dmitrij Bogush <dmitrij.bogush@gmail.com>,
       "" <linux-kernel@vger.kernel.org>
Subject: Re: snd-via82xx-modem do not work from 2.6.12 kernel version
In-Reply-To: <20050913235609.GB9531@tecr>
Message-ID: <Pine.LNX.4.50.0509131643010.3527-100000@shark.he.net>
References: <2ac89c70050913145926583918@mail.gmail.com> <20050913235609.GB9531@tecr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2005, Sasha Khapyorsky wrote:

> On 01:59 Wed 14 Sep     , Dmitrij Bogush wrote:
> > I try to get MC97 modem working with 2.6.14-rc1 and get "NO DIAL
> > TONE". I think that something wrong with driver source, becouse if
> > replace snd-via82xx-modem.c with 2.6.11 version and recompile modules
> > all works fine..
>
> Try with 2.6.13, this should be fixed.
>
> Sasha.

Sasha, his report was with 2.6.14-rc1 failing.
Should it (still) be fixed in 2.6.14-rc1?

-- 
~Randy
