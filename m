Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132294AbQKKBRT>; Fri, 10 Nov 2000 20:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132293AbQKKBRJ>; Fri, 10 Nov 2000 20:17:09 -0500
Received: from clavin.efn.org ([206.163.176.10]:40165 "EHLO clavin.efn.org")
	by vger.kernel.org with ESMTP id <S131845AbQKKBRB>;
	Fri, 10 Nov 2000 20:17:01 -0500
From: Steve VanDevender <stevev@efn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14860.40393.864532.703716@tzadkiel.efn.org>
Date: Fri, 10 Nov 2000 17:15:53 -0800
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: sendmail-bugs@sendmail.org, Igmar Palsenberg <maillist@chello.nl>,
        root@chaos.analogic.com, Andrea Arcangeli <andrea@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in 
 /var/spool/mqueue]
In-Reply-To: <3A0C8117.20853855@timpanogas.org>
In-Reply-To: <3A0C5EDC.3F30BE9C@timpanogas.org>
	<Pine.LNX.4.21.0011110113590.6465-100000@server.serve.me.nl>
	<20001110151232.A16552@sendmail.com>
	<3A0C8117.20853855@timpanogas.org>
X-Mailer: VM 6.81 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey writes:
 > There was also an issue relative to how sendmail is interpreting load
 > average on a linux box.  hpa@transmeta.com pointed out that perhaps you
 > are not factoring sleeping processes, which Linux does -- a deviation
 > from BSD's interpretation of load average.

At worst it's an issue with how Linux presents load average, not with
how sendmail interprets it -- sendmail believes what the kernel tells
it.  And from the sound of it, it's not even Linux's fault -- your box
has a high load average because it's got a lot of runnable processes.

 > With a handle like
 > "Assmann", deviation is proably something you already understand quite
 > well ...

Don't be a moron.  Claus is German, Assman really is his last name and
not some "handle", and it's pronounced "Oss-man".

I'm sure we could make plenty of stupid puns with "Merkey" too.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
