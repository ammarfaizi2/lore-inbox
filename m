Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136852AbRA1FH2>; Sun, 28 Jan 2001 00:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136872AbRA1FHJ>; Sun, 28 Jan 2001 00:07:09 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:21771 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S136852AbRA1FHE>;
	Sun, 28 Jan 2001 00:07:04 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Jacob Anawalt <anawaltaj@qwest.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Knowing what options a kernel was compiled with 
In-Reply-To: Your message of "Sat, 27 Jan 2001 22:21:41 PDT."
             <3A73AC65.FC9DD8C@qwest.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 28 Jan 2001 16:06:57 +1100
Message-ID: <4504.980658417@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jan 2001 22:21:41 -0700, 
Jacob Anawalt <anawaltaj@qwest.net> wrote:
>Is there a way to know what options a running kernel was compiled with,
>if you dont have access to the source or configure files it was compiled
>off of?

No.  You have to insist that whoever distributes the kernel binary also
distributes the .config file that it was compiled with.

Don't bother arguing that the kernel should record this info, it has
been discussed before and rejected.  This is a problem for the
distributors, not for the kernel.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
