Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133101AbQLIA2e>; Fri, 8 Dec 2000 19:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133115AbQLIA2Y>; Fri, 8 Dec 2000 19:28:24 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:30739 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133101AbQLIA2Q>; Fri, 8 Dec 2000 19:28:16 -0500
Subject: Re: Networking: RFC1122 and 1123 status for kernel 2.4
To: hch@ns.caldera.de (Christoph Hellwig)
Date: Sat, 9 Dec 2000 00:00:11 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), ak@suse.DE (Andi Kleen),
        linux-kernel@vger.kernel.org, torvalds@transmeta.com
In-Reply-To: <200012081934.UAA24478@ns.caldera.de> from "Christoph Hellwig" at Dec 08, 2000 08:34:26 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E144XR0-0004f0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That could even be automated when this little patch (against -test11, but
> -test12pre works too) is applied...

> +# MANPATH specifies where to install the manpages created from
> +# inline documentation
> +#
> +
> +MANDIR	:= /usr/share/man
> +

End user installed so

	/usr/local/man or /usr/local/share/man
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
