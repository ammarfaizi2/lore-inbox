Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318162AbSGWSQi>; Tue, 23 Jul 2002 14:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318164AbSGWSQi>; Tue, 23 Jul 2002 14:16:38 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:47744 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318162AbSGWSQh>; Tue, 23 Jul 2002 14:16:37 -0400
Subject: Re: kernel BUG at page_alloc.c:92! & page allocation failure.
	order:0, mode:0x0
From: Paul Larson <plars@austin.ibm.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: David F Barrera <dbarrera@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44L.0207231417110.3086-100000@imladris.surriel.com>
References: <Pine.LNX.4.44L.0207231417110.3086-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 23 Jul 2002 13:17:44 -0500
Message-Id: <1027448265.7700.19.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-23 at 12:17, Rik van Riel wrote:
> Does the attached patch fix it ?
> ===== mm/rmap.c 1.3 vs edited =====
> --- 1.3/mm/rmap.c	Tue Jul 16 18:46:30 2002
> +++ edited/mm/rmap.c	Tue Jul 23 14:01:23 2002

I doubt it, his probelem was on 2.5.26.

