Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317663AbSGOVzX>; Mon, 15 Jul 2002 17:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317664AbSGOVzX>; Mon, 15 Jul 2002 17:55:23 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:12039 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317663AbSGOVzW>; Mon, 15 Jul 2002 17:55:22 -0400
Date: Mon, 15 Jul 2002 23:58:14 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020715215814.GE26158@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020712162306$aa7d@traf.lcs.mit.edu> <s5gsn2lt3ro.fsf@egghead.curl.com> <20020715173337$acad@traf.lcs.mit.edu> <s5gsn2kst2j.fsf@egghead.curl.com> <20020715205505.GC30630@merlin.emma.line.org> <1026773712.31924.11.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1026773712.31924.11.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, Alan Cox wrote:

> We are only interested in reliable code. Anything else is already
> fatally broken.
> 
> -- quote --
>        Not checking the return value of close  is  a  common  but
>        nevertheless   serious  programming  error.   File  system

As in 6. on http://www.apocalypse.org/pub/u/paul/docs/commandments.html
(The Ten Commandments for C Programmers, by Henry Spencer).
