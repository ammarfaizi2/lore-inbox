Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270821AbRHNU2X>; Tue, 14 Aug 2001 16:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270815AbRHNU2H>; Tue, 14 Aug 2001 16:28:07 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:49162 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S270808AbRHNU1r>;
	Tue, 14 Aug 2001 16:27:47 -0400
Date: Tue, 14 Aug 2001 17:27:44 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Petr Baudis <pasky@pasky.ji.cz>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: WANTED: Re: VM lockup with 2.4.8 / 2.4.8pre8
In-Reply-To: <20010814220545.D31070@pasky.ji.cz>
Message-ID: <Pine.LNX.4.33L.0108141727030.6118-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Aug 2001, Petr Baudis wrote:

> I also propose to half badness of

Selecting which process to kill is not the problem
we are currently facing.

The problem is WHEN to kill something. Once we have
that fixed we can always work on refining the selection
algorithm ;))

Rik
--
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

