Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262384AbSLATT5>; Sun, 1 Dec 2002 14:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbSLATT5>; Sun, 1 Dec 2002 14:19:57 -0500
Received: from [200.193.163.106] ([200.193.163.106]:43437 "EHLO
	5-106.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262384AbSLATT4>; Sun, 1 Dec 2002 14:19:56 -0500
Date: Sun, 1 Dec 2002 17:27:03 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Javier Marcet <jmarcet@pobox.com>
cc: Steffen Moser <lists@steffen-moser.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Exaggerated swap usage
In-Reply-To: <20021201075756.GB2483@jerry.marcet.dyndns.org>
Message-ID: <Pine.LNX.4.44L.0212011726130.15981-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Dec 2002, Javier Marcet wrote:

> >This should be fixed in rmap15.
>
> Is rmap15 included in 2.4.20-rc4-ac1?

No, -ac is still on rmap14.  Alan may be adventurous with his
own code, but he certainly doesn't fool around with the VM.
I usually only send him -rmap code that's been tested for a
number of weeks...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

