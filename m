Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSIZPeA>; Thu, 26 Sep 2002 11:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261400AbSIZPeA>; Thu, 26 Sep 2002 11:34:00 -0400
Received: from pD9E23892.dip.t-dialin.net ([217.226.56.146]:65254 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S261398AbSIZPd7>; Thu, 26 Sep 2002 11:33:59 -0400
Date: Thu, 26 Sep 2002 09:39:33 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Rik van Riel <riel@conectiva.com.br>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Tomas Szepe <szepe@pinerecords.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH][2.5] Single linked lists for Linux,v2
In-Reply-To: <Pine.LNX.4.44L.0209261157291.15154-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0209260934170.7827-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 26 Sep 2002, Rik van Riel wrote:
> If I were you, I'd take a large piece of paper and make
> a drawing of what the data structure looks like and what
> the various macros/functions are supposed to do.

Well, I know what they _should_ do. But I don't know what I should 
initialize an empty list entry to. That's not got much spam in it...

			Thunder
-- 
assert(typeof((fool)->next) == typeof(fool));	/* wrong */

