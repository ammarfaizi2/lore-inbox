Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129318AbQKKCTC>; Fri, 10 Nov 2000 21:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129316AbQKKCSm>; Fri, 10 Nov 2000 21:18:42 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:28421 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129302AbQKKCSl>; Fri, 10 Nov 2000 21:18:41 -0500
Date: Fri, 10 Nov 2000 20:14:49 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Steve VanDevender <stevev@efn.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Fwd: sendmail fails to deliver mail with attachments in /var/spool/mqueue]
Message-ID: <20001110201449.A3285@vger.timpanogas.org>
In-Reply-To: <3A0C5EDC.3F30BE9C@timpanogas.org> <Pine.LNX.4.21.0011110113590.6465-100000@server.serve.me.nl> <20001110151232.A16552@sendmail.com> <3A0C8117.20853855@timpanogas.org> <14860.40393.864532.703716@tzadkiel.efn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <14860.40393.864532.703716@tzadkiel.efn.org>; from stevev@efn.org on Fri, Nov 10, 2000 at 05:15:53PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2000 at 05:15:53PM -0800, Steve VanDevender wrote:
> Jeff V. Merkey writes:
>  > There was also an issue relative to how sendmail is interpreting load
>  > average on a linux box.  hpa@transmeta.com pointed out that perhaps you
>  > are not factoring sleeping processes, which Linux does -- a deviation
>  > from BSD's interpretation of load average.
> 
> At worst it's an issue with how Linux presents load average, not with
> how sendmail interprets it -- sendmail believes what the kernel tells
> it.  And from the sound of it, it's not even Linux's fault -- your box
> has a high load average because it's got a lot of runnable processes.
> 
>  > With a handle like
>  > "Assmann", deviation is proably something you already understand quite
>  > well ...
> 
> Don't be a moron.  Claus is German, Assman really is his last name and
> not some "handle", and it's pronounced "Oss-man".
> 
> I'm sure we could make plenty of stupid puns with "Merkey" too.

I had no idea, I was making a joke.  It looked like a handle, I apologize 
for being culturally ignorant of being able to distinguishing it.  

8)

jeff

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
