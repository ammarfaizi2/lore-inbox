Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318138AbSG2XtK>; Mon, 29 Jul 2002 19:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318143AbSG2XtK>; Mon, 29 Jul 2002 19:49:10 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:33032 "HELO
	garrincha.netbank.com.br") by vger.kernel.org with SMTP
	id <S318138AbSG2XtJ>; Mon, 29 Jul 2002 19:49:09 -0400
Date: Mon, 29 Jul 2002 20:51:51 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Theurer <habanero@us.ibm.com>,
       <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: Linux 2.4.19-rc3 (hyperthreading)
In-Reply-To: <20020729234558.GM1201@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0207292051040.3086-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jul 2002, Andrea Arcangeli wrote:

> and the new one had a bug too :). Please merge the fix I posted to l-k
> too thanks.

Judging from the patch the code seems incredibly subtle and
I'd be amazed if it doesn't break again every few weeks...

regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

