Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129231AbQLFUyi>; Wed, 6 Dec 2000 15:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQLFUy2>; Wed, 6 Dec 2000 15:54:28 -0500
Received: from [212.187.250.66] ([212.187.250.66]:58892 "HELO
	proxy.jakinternet.co.uk") by vger.kernel.org with SMTP
	id <S129231AbQLFUyO>; Wed, 6 Dec 2000 15:54:14 -0500
To: linux-irda@pasta.cs.UiT.No
From: Jonathan Hudson <jrhudson@bigfoot.com>
Mime-Version: 1.0
X-Newsreader: knews 1.0b.1
x-no-productlinks: yes
X-Comment-To: Dag Brattli
In-Reply-To: <ML-3.4.976001530.9383.crosser@pccross.average.org> <200012050828.IAA75218@tepid.osl.fast.no>
Subject: Re: [Linux-IrDA] Re: [IrDA]Oops while shutting down irattach
X-Newsgroups: local.site.irda
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=iso-8859-1
NNTP-Posting-Host: 192.168.1.1
Message-ID: <18de.3a2e9ea9.9ebae@trespassersw.daria.co.uk>
Date: Wed, 06 Dec 2000 20:16:41 GMT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <200012050828.IAA75218@tepid.osl.fast.no>,
	Dag Brattli <dagb@fast.no> writes:
DB> else. I''ve tried to find it, but I'm still clueless at the prompt.

Fixed by the exec_usermodehelper fixes in 2.4.0test12pre6 (at least here:).

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
