Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbSLYVVh>; Wed, 25 Dec 2002 16:21:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261333AbSLYVVh>; Wed, 25 Dec 2002 16:21:37 -0500
Received: from m83-mp1.cvx2-c.ren.dial.ntli.net ([62.252.152.83]:41205 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S261330AbSLYVVg>; Wed, 25 Dec 2002 16:21:36 -0500
Subject: Re: [STATUS 2.5]  December 24, 2002
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50L.0212241523200.26879-100000@imladris.surriel.com>
References: <63942A45-1722-11D7-8DC6-000393950CC2@karlsbakk.net> 
	<Pine.LNX.4.50L.0212241523200.26879-100000@imladris.surriel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Dec 2002 21:28:19 +0000
Message-Id: <1040851699.1109.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-24 at 17:23, Rik van Riel wrote:
> > stable...
> 
> My guess is that nobody submitted a bug report about TCQ ;)

TCQ is completely broken on some controls. I know about it. I don't care
about it and I assume Jens will tidy it up when he has finished the more
important stuff. If not its no big deal to kill it until 2.7 - one
trivial config script change

