Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317511AbSGOQLU>; Mon, 15 Jul 2002 12:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSGOQLT>; Mon, 15 Jul 2002 12:11:19 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:63751 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317511AbSGOQLR>; Mon, 15 Jul 2002 12:11:17 -0400
Date: Mon, 15 Jul 2002 13:13:31 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Weber, Frank" <FWeber@ndsuk.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Process-wise swap-on/off option
In-Reply-To: <1A961872F9CE0B4AB641DD256115865F225C5E@tornado.uk.nds.com>
Message-ID: <Pine.LNX.4.44L.0207151313110.12241-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, Weber, Frank wrote:

> 	"... lock (a certain) stack and data segment ...
> 	into memory so that it can't be swapped out"?

> Any hints as to where to look for a solution (i.e.,
> pointers to documentation or manuals where the ifs
> and hows are explained) would be greatly appreciated.

man mlock

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

