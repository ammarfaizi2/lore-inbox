Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293541AbSCKW3m>; Mon, 11 Mar 2002 17:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293543AbSCKW30>; Mon, 11 Mar 2002 17:29:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38671 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293541AbSCKW3H>; Mon, 11 Mar 2002 17:29:07 -0500
Subject: Re: [PATCH] 2.5.6 IDE 19
To: riel@conectiva.com.br (Rik van Riel)
Date: Mon, 11 Mar 2002 22:44:29 +0000 (GMT)
Cc: arjanv@redhat.com (Arjan van de Ven),
        dalecki@evision-ventures.com (Martin Dalecki),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44L.0203111802070.2181-100000@imladris.surriel.com> from "Rik van Riel" at Mar 11, 2002 06:02:38 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16kYWr-0001ys-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > the OS gets involved.
> > Just "don't enable" is not an option.
> 
> I've heard some talk about drives that turn it on
> automatically when they get "too busy".

Its also a pain because some drives seem to drop into snail racing mode
when you turn it off
