Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129327AbRBUN4d>; Wed, 21 Feb 2001 08:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129361AbRBUN4Y>; Wed, 21 Feb 2001 08:56:24 -0500
Received: from nmh.informatik.uni-bremen.de ([134.102.224.3]:16541 "EHLO
	nmh.informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id <S129327AbRBUN4I>; Wed, 21 Feb 2001 08:56:08 -0500
To: Jes Sorensen <jes@linuxcare.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        davem@redhat.com
Subject: Re: Problem with 2.2.19pre9 (Connection closed.)
In-Reply-To: <E14VZCs-00023R-00@the-village.bc.nu> <d3g0h8nou5.fsf@lxplus015.cern.ch>
From: Markus Germeier <mager@tzi.de>
Date: 21 Feb 2001 14:55:43 +0100
In-Reply-To: Jes Sorensen's message of "21 Feb 2001 14:32:50 +0100"
Message-ID: <941yss9m3k.fsf@religion.informatik.uni-bremen.de>
User-Agent: Gnus/5.0802 (Gnus v5.8.2) Emacs/20.6
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen <jes@linuxcare.com> writes:

> I only see this for connections with incoming traffic where I don't
> send something out (like irc), whereas unused ssh connections seem to
> survive fine.

Just for the record: My example was an idle ssh connection!

I believe Alan is correct. I can't remember having this problem with
another linux box. I'll try to reproduce this with a linux box.

Thanks for your quick responses. Hopefully we can resolve this before
2.2.19 comes out!

Regards
        Markus

-- 
Markus Germeier
mager@tzi.de
