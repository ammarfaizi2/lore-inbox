Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270467AbTGNQdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 12:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270640AbTGNQdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 12:33:22 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:64476 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270467AbTGNQcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 12:32:08 -0400
Date: Mon, 14 Jul 2003 13:44:26 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: John Bradford <john@grabjohn.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: Linux v2.6.0-test1
In-Reply-To: <1058195269.561.72.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.55L.0307141343370.28660@freak.distro.conectiva>
References: <200307141139.h6EBd09g000700@81-2-122-30.bradfords.org.uk> 
 <1058182417.561.47.camel@dhcp22.swansea.linux.org.uk> 
 <Pine.LNX.4.55L.0307141055530.18257@freak.distro.conectiva>
 <1058195269.561.72.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Jul 2003, Alan Cox wrote:

> On Llu, 2003-07-14 at 14:56, Marcelo Tosatti wrote:
> > > Then you'll just have to wait a few months
> >
> > I will start looking at 2.4 security fixes which are not applied in 2.6.
> >
> > If someone is already doing that, please tell me.
>
> I'm working on the recent exec and proc stuff. strncpy needs people who can
> do their native asm though.

Right. I'll look at any other possible (misc) security problem which is
fixed in 2.4.
