Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129626AbQKTSuC>; Mon, 20 Nov 2000 13:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129205AbQKTStw>; Mon, 20 Nov 2000 13:49:52 -0500
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:58780 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129251AbQKTStj>; Mon, 20 Nov 2000 13:49:39 -0500
Date: Mon, 20 Nov 2000 13:19:33 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Tigran Aivazian <tigran@veritas.com>
cc: Bernhard Rosenkraenzer <bero@redhat.de>, <linux-kernel@vger.kernel.org>
Subject: Re: Defective Red Hat Distribution poorly represents Linux
In-Reply-To: <Pine.LNX.4.21.0011201700580.1059-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.30.0011201315460.9463-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the risk of being flamed for a distribution type discussion...

Security nuts are probably rolling on the floor laughing at you for
these two. I can think of some situations where these would be usefull
though.

On Mon, 20 Nov 2000, Tigran Aivazian wrote:

> 3) edit /etc/ftpusers to allow root ftp
>
> 4) edit /etc/pam.d/login and /etc/pam.d/rlogin to comment out securetty
> PAM module (so we can telnet as root on _any_ tty)
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
