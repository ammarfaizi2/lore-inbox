Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290552AbSAYEwZ>; Thu, 24 Jan 2002 23:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290553AbSAYEwP>; Thu, 24 Jan 2002 23:52:15 -0500
Received: from snipe.mail.pas.earthlink.net ([207.217.120.62]:56023 "EHLO
	snipe.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S290552AbSAYEwN>; Thu, 24 Jan 2002 23:52:13 -0500
Date: Thu, 24 Jan 2002 23:56:08 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18pre4aa1
Message-ID: <20020124235608.C1096@earthlink.net>
In-Reply-To: <20020124222357.C901@earthlink.net> <Pine.LNX.4.33L.0201250132450.32617-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0201250132450.32617-100000@imladris.surriel.com>; from riel@conectiva.com.br on Fri, Jan 25, 2002 at 01:35:08AM -0200
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> workloads, I'm not sure I want to make the system more
> unfair just to better accomodate dbench ;)

I'm wondering if rmap is a little too aggressive on 
read-ahead, and if that has a negative impact on
a complex workload.

-- 
Randy Hron

