Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129741AbQLHPQA>; Fri, 8 Dec 2000 10:16:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130607AbQLHPPv>; Fri, 8 Dec 2000 10:15:51 -0500
Received: from smtp03.mrf.mail.rcn.net ([207.172.4.62]:9215 "EHLO
	smtp03.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S129414AbQLHPPg>; Fri, 8 Dec 2000 10:15:36 -0500
Date: Fri, 8 Dec 2000 09:44:59 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Rik van Riel <riel@conectiva.com.br>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Jeff V. Merkey" <jmerkey@timpanogas.org>,
        Peter Samuelson <peter@cadcamlab.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: NTFS repair tools]
In-Reply-To: <Pine.LNX.4.21.0012081226160.8655-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.4.30.0012080938560.11198-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You know, couldn't we do something like prompting the (l)user with an
disclaimer/agreement or something when selecting the option or maybe
even when doing a make dep?

They'd prolly blast through it without reading (You don't think they
read teh MS agreement when istalling windows do you?) but I bet we could
argue that they accepted the agreement to protect us.


Rik:
I got a little diff happy ;-P

--- index.html.old	Fri Dec  8 09:35:58 2000
+++ index.html	Fri Dec  8 09:38:03 2000
@@ -21,7 +21,7 @@
 <p>If you spot a gem that's suitable for placement on this
 page, please <a href="mailto:riel@nl.linux.org">mail me</a>.

-<p><address>Rik van Riel, feb 11 2000</address>
+<p><address>Rik van Riel, dec 08 2000</address>

 <table width=100%><tr>
 <td><a href="/">Back to surriel.com</a>
@@ -31,14 +31,14 @@
 <hr>

 <ul>
-<li>April 2000: <a href="dec2000.shtml">fs/Config.in</a> by
+<li>December 2000: <a href="dec2000.shtml">fs/Config.in</a> by
     Peter Samuelson.
+<li>June 2000: <a href="jun2000.shtml">kernel/sys.c patch</a> by
+    Dominik Rothert.
 <li>April 2000: <a href="apr2000.shtml">drivers/block/floppy.c</a> by
     Tim Waugh.
 <li>February 2000: <a href="feb2000.shtml">mm/swapfile.c patch</a> by
     Aaron Botsis.
-<li>June 2000: <a href="jun2000.shtml">kernel/sys.c patch</a> by
-    Dominik Rothert.
 </ul>

 </body>

On Fri, 8 Dec 2000, Rik van Riel wrote:
> I must say I like the CONFIG_MORON though. By setting that the
> (l)user exposes his true identity and leaves little for us to
> doubt ;)
>
> Added to the Patch of the Month page as suggested by David
> Weinehall:
>
> 	http://www.surriel.com/potm/
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
