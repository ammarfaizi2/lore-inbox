Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131841AbQLJTbo>; Sun, 10 Dec 2000 14:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131865AbQLJTbe>; Sun, 10 Dec 2000 14:31:34 -0500
Received: from gw.brfsodrahamn.se ([195.54.141.30]:26597 "HELO
	tuttifrutti.cdt.luth.se") by vger.kernel.org with SMTP
	id <S131841AbQLJTbR> convert rfc822-to-8bit; Sun, 10 Dec 2000 14:31:17 -0500
X-Mailer: exmh version 2.2 10/15/1999 with nmh-1.0.4
From: Hakan Lennestal <hakanl@cdt.luth.se>
Reply-To: Hakan Lennestal <hakanl@cdt.luth.se>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Hakan Lennestal <hakanl@cdt.luth.se>, gsharp@ihug.co.nz,
        linux-kernel@vger.kernel.org
Subject: Re: HPT366 + SMP = slight corruption in 2.3.99 - 2.4.0-11 
In-Reply-To: Your message of "Sun, 10 Dec 2000 09:17:28 PST."
             <Pine.LNX.4.10.10012100916360.8764-100000@master.linux-ide.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Sun, 10 Dec 2000 20:01:10 +0100
Message-Id: <20001210190116.30924418A@tuttifrutti.cdt.luth.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.10.10012100916360.8764-100000@master.linux-ide.org>, And
re Hedrick writes:
> On Sun, 10 Dec 2000, Hakan Lennestal wrote:
> 
> > The problem being that the kernel hangs after a dma timeout in the
> > partition detection phase during bootup for speeds higher than udma 44.
> > This is an IBM-DTLA-307030 connected to a hpt366 pci card on a BH6
> > motherboard.
> 
> Well try the latest out there...test12-pre7.

Hi !

This is with test12-pre7 and HPT-bios 1.27.

Regards.

/Håkan


---------------------------------------
e-mail: Hakan.Lennestal@lu.erisoft.se |
     or Hakan.Lennestal@cdt.luth.se   |
---------------------------------------

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
