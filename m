Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318901AbSICVLv>; Tue, 3 Sep 2002 17:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318926AbSICVLv>; Tue, 3 Sep 2002 17:11:51 -0400
Received: from 2-210.ctame701-1.telepar.net.br ([200.193.160.210]:17285 "EHLO
	2-210.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S318901AbSICVLu>; Tue, 3 Sep 2002 17:11:50 -0400
Date: Tue, 3 Sep 2002 18:15:45 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Peter T. Breuer" <ptb@it.uc3m.es>
cc: Lars Marowsky-Bree <lmb@suse.de>, <root@chaos.analogic.com>,
       linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] mount flag "direct" (fwd)
In-Reply-To: <200209032107.g83L71h10758@oboe.it.uc3m.es>
Message-ID: <Pine.LNX.4.44L.0209031814201.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Sep 2002, Peter T. Breuer wrote:

> The "big view" calculations indicate that we must have distributed
> shared writable data.

Agreed.  Note that the same big view also dictates that any such
solution must have good performance.

Do you need any more reasons for having special cluster filesystems
instead of trying to add clustering to already existing filesystems ?

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

