Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292320AbSBYVwe>; Mon, 25 Feb 2002 16:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292324AbSBYVwP>; Mon, 25 Feb 2002 16:52:15 -0500
Received: from mail.cert.uni-stuttgart.de ([129.69.16.17]:2539 "HELO
	Mail.CERT.Uni-Stuttgart.DE") by vger.kernel.org with SMTP
	id <S292308AbSBYVvz>; Mon, 25 Feb 2002 16:51:55 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.18
In-Reply-To: <Pine.LNX.4.21.0202251537080.31438-100000@freak.distro.conectiva>
From: Florian Weimer <Weimer@CERT.Uni-Stuttgart.DE>
Date: Mon, 25 Feb 2002 22:45:29 +0100
In-Reply-To: <Pine.LNX.4.21.0202251537080.31438-100000@freak.distro.conectiva> (Marcelo
 Tosatti's message of "Mon, 25 Feb 2002 15:37:38 -0300 (BRT)")
Message-ID: <87y9hhfd6u.fsf@CERT.Uni-Stuttgart.DE>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) Emacs/21.1 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> - Fix netfilter race				(Rusty Russell)
> - Correct error handling on tcp_recvmsg		(Alexey Kuznetsov)
> - Revert tulip changes which were apparently
>   causing slowdowns				(Jeff Garzik) 
> - Fix ptrace behaviour				(Linus Benedict Torvalds)

Are any of these relevant, security-wise?

(The shmem_file_write() fix by Alan Cox is indeed.)

-- 
Florian Weimer 	                  Weimer@CERT.Uni-Stuttgart.DE
University of Stuttgart           http://CERT.Uni-Stuttgart.DE/people/fw/
RUS-CERT                          +49-711-685-5973/fax +49-711-685-5898
