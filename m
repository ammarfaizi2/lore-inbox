Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262857AbREVVrH>; Tue, 22 May 2001 17:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262850AbREVVq6>; Tue, 22 May 2001 17:46:58 -0400
Received: from pD951FCDB.dip.t-dialin.net ([217.81.252.219]:39173 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S262848AbREVVqn>; Tue, 22 May 2001 17:46:43 -0400
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: "Brent D. Norris" <brent@biglinux.tccw.wku.edu>,
        "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-net@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-hams@vger.kernel.org>,
        <linux-ppp@vger.kernel.org>
Subject: Re: ECN is on!
In-Reply-To: <15114.18990.597124.656559@pizda.ninka.net>
	<Pine.LNX.4.30.0105220649530.17291-100000@biglinux.tccw.wku.edu>
	<200105221306.f4MD6Pi00360@mobilix.ras.ucalgary.ca>
In-Reply-To: <200105221306.f4MD6Pi00360@mobilix.ras.ucalgary.ca>
From: Matthias Andree <ma@dt.e-technik.uni-dortmund.de>
Date: 22 May 2001 23:46:37 +0200
Message-ID: <m3ititxdj6.fsf@emma1.emma.line.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Gooch <rgooch@ras.ucalgary.ca> writes:

> Sure, Dave is being bloody-minded, but that's the only way we'll see
> people get off their fat, lazy asses and fix their broken systems.
> In fact, hopefully he's still in a dark mood, and he may take up the
> suggestion to bounce mails of the following type:
> - MIME encoded
> - HTML encoded
> - quoted printables (those stupid "=20" things are particuarly hard to
>   read).

MIME is no encoding, but a way to declare mail contents and encode
binary data. You need not use it on mail you send.

HTML is no encoding. (No doubt it's usually sent by people without A
Clue[tm] or being ruthless.)

quoted-printable is an encoding, and it's probably around for ten years
now. I can send base64 if you like that better, but then, even more
people will cry, while others don't even notice. 

Gnus 5.8 + Emacs, mutt, Netscape Communicator are three packages which
deal with MIME-"enhanced" mail.

Plus, people which use any characters beyond ASCII have no real choice
but to use MIME; if they have MTAs in between that don't talk
ESMTP/8BITMIME, then quoted-printable is what happens.

Use emil, metamail or such if you want to keep your mailer.

-- 
Matthias Andree
