Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318357AbSHPNdl>; Fri, 16 Aug 2002 09:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318360AbSHPNdl>; Fri, 16 Aug 2002 09:33:41 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:31754 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318357AbSHPNdk>; Fri, 16 Aug 2002 09:33:40 -0400
Date: Fri, 16 Aug 2002 10:37:15 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre2-ac3 stops responding
In-Reply-To: <3D5CFE83.136D81FC@wanadoo.fr>
Message-ID: <Pine.LNX.4.44L.0208161036170.1430-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2002, Jean-Luc Coulon wrote:

> 2nd while running:
> ------------------
> If I have high disk activity, the system stops responding for a while,
> it does not accepts any key action nor mouse movement. It starts running
> normally after few seconds.

I've got a patch that might help improve this situation:

http://surriel.com/patches/2.4/2.4.20-p2ac3-rmap14

Could you please try this patch ?

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

