Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317528AbSGJP5i>; Wed, 10 Jul 2002 11:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317533AbSGJP5h>; Wed, 10 Jul 2002 11:57:37 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:59911 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S317528AbSGJP5g>; Wed, 10 Jul 2002 11:57:36 -0400
Date: Wed, 10 Jul 2002 12:49:32 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Guillaume Boissiere <boissiere@adiglobal.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  July 10, 2002
In-Reply-To: <3D2B89AC.25661.91896FEB@localhost>
Message-ID: <Pine.LNX.4.44L.0207101247440.14432-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2002, Guillaume Boissiere wrote:

> Also on the planned deletion list:
>    - Add thrashing control

I've had the mechanism working for well over a year now, but
still don't have a proper policy for load control implemented.

> o Beta        New VM with reverse mappings                    (Rik van Riel)

This is (in limited form) ready for merging and has been
stability tested by Andrew Morton. A patch should go to
Linus soon...

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

