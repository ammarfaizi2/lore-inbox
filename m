Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131593AbQKJT4z>; Fri, 10 Nov 2000 14:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131695AbQKJT4p>; Fri, 10 Nov 2000 14:56:45 -0500
Received: from Cantor.suse.de ([194.112.123.193]:15121 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131593AbQKJT4i>;
	Fri, 10 Nov 2000 14:56:38 -0500
Date: Fri, 10 Nov 2000 20:51:29 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue]
Message-ID: <20001110205129.A4344@inspiron.suse.de>
In-Reply-To: <3A0C4252.100D863D@timpanogas.org> <20001110203506.A1028@inspiron.suse.de> <3A0C4DD0.DE90E364@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A0C4DD0.DE90E364@timpanogas.org>; from jmerkey@timpanogas.org on Fri, Nov 10, 2000 at 12:34:40PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 12:34:40PM -0700, Jeff V. Merkey wrote:
> 
> Andrea,
> 
> All done.  It's already setup this way.

Ok. So please now show a tcpdump trace during the `sendmail -q` so we can see
what's going wrong in the TCP connection to the smtp server:

	tcpdump port smtp

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
