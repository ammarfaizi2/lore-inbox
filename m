Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbQLYBuE>; Sun, 24 Dec 2000 20:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129370AbQLYBty>; Sun, 24 Dec 2000 20:49:54 -0500
Received: from web1003.mail.yahoo.com ([128.11.23.93]:60434 "HELO
	web1003.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129289AbQLYBth>; Sun, 24 Dec 2000 20:49:37 -0500
Message-ID: <20001225011910.9551.qmail@web1003.mail.yahoo.com>
Date: Sun, 24 Dec 2000 17:19:10 -0800 (PST)
From: Ron Calderon <ronnnyc@yahoo.com>
Subject: Re: sparc 10 w/512 megs hangs during boot
To: jbglaw@lug-owl.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

test8 is borked too. I'll try test7 next

ron
--- Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
> On Sun, Dec 24, 2000 at 12:48:44PM -0800, Ron
> Calderon wrote:
> > I just finished compiling 2.4.0-test5 and that
> worked
> > fine with 512M ram. I'll start going thru the
> other
> > kernels. It'll take me sometime since compileing
> takes
> > a long time.
> 
> I've not yet started active searching. However:
> 	- test5		is fine
> 	- test13-pre3	is not
> 
> I don't know how fast your machine is, but we should
> coordinate out
> search... I'll try to build -test10final (with
> minimal config to
> only test boot) so that shouldn't take so very
> long... You should
> test sth around -test8...
> 
> MfG, JBG
> 
> -- 
> Fehler eingestehen, Größe zeigen: Nehmt die
> Rechtschreibreform zurück!!!
> /* Jan-Benedict Glaw <jbglaw@lug-owl.de> --
> +49-177-5601720 */
> keyID=0x8399E1BB fingerprint=250D 3BCF 7127 0D8C
> A444 A961 1DBD 5E75 8399 E1BB
>      "insmod vi.o and there we go..." (Alexander
> Viro on linux-kernel)
> 

> ATTACHMENT part 2 application/pgp-signature 



__________________________________________________
Do You Yahoo!?
Yahoo! Shopping - Thousands of Stores. Millions of Products.
http://shopping.yahoo.com/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
