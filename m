Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSHINzc>; Fri, 9 Aug 2002 09:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSHINzc>; Fri, 9 Aug 2002 09:55:32 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:42765 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S312560AbSHINzc>; Fri, 9 Aug 2002 09:55:32 -0400
Date: Fri, 9 Aug 2002 10:59:00 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
cc: Chris Adams <cmadams@hiwaay.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Linux-2.5 fix/improve get_pid()
In-Reply-To: <200208090704.g7974Td55043@saturn.cs.uml.edu>
Message-ID: <Pine.LNX.4.44L.0208091058140.23404-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Aug 2002, Albert D. Cahalan wrote:

> I almost put 99999, but then I realized that that's silly.
> For years Linux had a hard limit of about 4000 processes,

That limit was removed some 2 years ago.

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

