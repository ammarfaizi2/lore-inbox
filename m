Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316210AbSEOBqh>; Tue, 14 May 2002 21:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316249AbSEOBqg>; Tue, 14 May 2002 21:46:36 -0400
Received: from holomorphy.com ([66.224.33.161]:47519 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S316210AbSEOBqg>;
	Tue, 14 May 2002 21:46:36 -0400
Date: Tue, 14 May 2002 18:41:27 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC][PATCH] iowait statistics
Message-ID: <20020515014127.GD27957@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Bill Davidsen <davidsen@tmr.com>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.44L.0205132214480.32261-100000@imladris.surriel.com> <Pine.LNX.3.96.1020514212343.2164A-200000@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2002 at 09:31:30PM -0400, Bill Davidsen wrote:
> *** ./Makefile	Tue May 14 14:59:18 2002
> --- ../linux-2.4.19-pre8-ac3p/./Makefile	Tue May 14 17:01:49 2002
> ***************
> *** 1,7 ****
>   VERSION = 2
>   PATCHLEVEL = 4
>   SUBLEVEL = 19
> ! EXTRAVERSION = -pre8-ac3
>   
>   KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

These look like patch rejects, not patches themselves.
Resend?


Cheers,
Bill
