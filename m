Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263667AbTLSXzm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 18:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbTLSXzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 18:55:42 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:25069 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S263667AbTLSXzm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 18:55:42 -0500
Date: Fri, 19 Dec 2003 15:55:21 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Maciej Zenczykowski <maze@cela.pl>
Cc: Arnaud Fontaine <arnaud@andesi.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Oops with 2.4.23
Message-ID: <20031219235521.GK6438@matchmail.com>
Mail-Followup-To: Maciej Zenczykowski <maze@cela.pl>,
	Arnaud Fontaine <arnaud@andesi.org>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20031219224402.GA1284@scrappy> <Pine.LNX.4.44.0312200034560.15516-100000@gaia.cela.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0312200034560.15516-100000@gaia.cela.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 20, 2003 at 12:35:24AM +0100, Maciej Zenczykowski wrote:
> > So i have just tested to run memtest86 on my box and i have had no error
> > with this. I have also tested cpuburn without any result. Have you some
> > others ideas ?
> 
> you did run memtest for a minimum dozen hours? sometimes it takes that 
> long to find errors...

Has anyone noticed if several runs with the normal tests, or a single test
with all tests running catches more errors?
