Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261827AbSJIQRf>; Wed, 9 Oct 2002 12:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261829AbSJIQRf>; Wed, 9 Oct 2002 12:17:35 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:20864 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261827AbSJIQRe>; Wed, 9 Oct 2002 12:17:34 -0400
Date: Wed, 9 Oct 2002 13:22:58 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Guillaume Boissiere <boissiere@adiglobal.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [STATUS 2.5]  October 9, 2002
In-Reply-To: <3DA41B88.14599.2336B580@localhost>
Message-ID: <Pine.LNX.4.44L.0210091319510.1648-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Guillaume Boissiere wrote:

> The latest 2.5 status update is available at
>     http://www.kernelnewbies.org/status

> o Ready  Remove the 2TB block device limit  (Peter Chubb)
> o Ready ext2/ext3 large directory support: HTree index (Daniel Phillips, Christopher Li, Andrew Morton, Ted Ts'o)

I think these ones are in -mm already.

> o Beta  Page table sharing  (Daniel Phillips, Dave McCracken)

This one seems nearly ready.

> o Alpha  NUMA aware scheduler extensions  (Erich Focht)

Reclassify as beta ?

> o Alpha  Page table reclamation  (William Lee Irwin, Rik Van Riel)

There is some code around, but there are a ton of other
things asking for attention at the moment ;(

regards,

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

