Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751911AbWI3UK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbWI3UK0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 16:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751914AbWI3UK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 16:10:26 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:18346 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751911AbWI3UKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 16:10:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QY+YkW2DPyUUB3ilNpA/UhYPEt2imiOo4gW6eEGYTaUmjx9P7MYg7AIWdpu8jBLX7z6NtNgJs2NqZZ4ubQxp+NsiSXBWiYD6YQBnOR4LW1GvouvuMYJ5z6WZduuI/VCwrqafWMiQWYkppdljJxuG9lz/81qXJ2HfpEqeBuxpT/E=
Message-ID: <653402b90609301310l54abf3a3y82f4f3e20d9f1394@mail.gmail.com>
Date: Sat, 30 Sep 2006 20:10:24 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Miguel Ojeda Sandonis" <maxextreme@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 V6] drivers: add lcd display support
In-Reply-To: <20060930123928.GV30245@lug-owl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060930132253.8ccaa0ad.maxextreme@gmail.com>
	 <20060930123928.GV30245@lug-owl.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/06, Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:
>
> AFAIK, the 'D' in LCD is already an abbreviation for "display", so
> could we name it lcdisplay or something like that?
>

My first guess was "lcd" ("d" as display), but there were already
devices with such name. So I chose "display", as they are additional
small displays (LCD or not). However, people thought it was a very
common name. Then I chose "LCD Display". Such name is more expressive
(it is "a Display, LCD type") and doesn't makes trouble with new lcd
screens, or the "lcd" drivers, or...

I don't care really about the name with or without "double d". Can
someone else give his/her opinion about this?

Thank you,
       Miguel Ojeda

> MfG, JBG
>
> --
>       Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
> Signature of:  The real problem with C++ for kernel modules is: the language just sucks.
> the second  :                                            -- Linus Torvalds
>
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.1 (GNU/Linux)
>
> iD8DBQFFHmWAHb1edYOZ4bsRAkdpAJ4g9+GPFYU4Y5W7JdGZXFDCmBDIggCfe6dk
> 3FbG+mcZQ+10MNkq5wC9J7w=
> =KzkJ
> -----END PGP SIGNATURE-----
>
>
>
