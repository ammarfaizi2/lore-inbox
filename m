Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317500AbSGOOuk>; Mon, 15 Jul 2002 10:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317503AbSGOOuj>; Mon, 15 Jul 2002 10:50:39 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:60425 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317500AbSGOOui>; Mon, 15 Jul 2002 10:50:38 -0400
Date: Mon, 15 Jul 2002 11:52:59 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: willy@w.ods.org, <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207151127.g6FBRCmc020464@burner.fokus.gmd.de>
Message-ID: <Pine.LNX.4.44L.0207151152080.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, Joerg Schilling wrote:

> I would be happy to hear about concepts. Currently it looks as if at
> least some people like to keep everything as it is. This is not a
> conceptional OS but a grown structure. If you like to keep code
> maintainable for a long time, you need to clean up the thicket from time
> to time.

I couldn't agree more.  Now, why do you oppose cleaning up
the "use scsi as everyone's mid layer" hack and putting a
better generic abstraction in place ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

