Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263126AbSJGQAy>; Mon, 7 Oct 2002 12:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263133AbSJGQAy>; Mon, 7 Oct 2002 12:00:54 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:661 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S263126AbSJGQAx>; Mon, 7 Oct 2002 12:00:53 -0400
Date: Mon, 7 Oct 2002 13:06:21 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: Rob Landley <landley@trommello.org>, <linux-kernel@vger.kernel.org>
Subject: Re: New BK License Problem?
In-Reply-To: <20021007154303.GB20941@ravel.coda.cs.cmu.edu>
Message-ID: <Pine.LNX.4.44L.0210071303180.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Oct 2002, Jan Harkes wrote:

> I'm expecting that all the BK->gnu patch gateways will be shut down in
> about 5 years,

I doubt that, the BK->patch "gateway" is a necessary part of
kernel development.  Without it, bitkeeper would stop being
useful.

I could be wrong, but I'm under the impression that Larry
doesn't want others to just copy bitkeeper to come up with a
free tool almost as good as bitkeeper.  There is no vendor
lock-in or anything else going on, afaics.

People who want to make something better than bitkeeper can
simply rsync the BK/SCCS repository from nl.linux.org and
use some SCCS clone to import the kernel data and commit
comments into their own repository ... they just can't use
bitkeeper to help them with their work.

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

