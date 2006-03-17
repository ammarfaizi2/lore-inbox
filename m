Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWCQMGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWCQMGF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 07:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWCQMGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 07:06:05 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:36368 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750859AbWCQMGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 07:06:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=q1Fc3BswDDFJlk1scCFakZnUEKBZf37iKpERNa6/lkoEfDfkvX/hW8a6LCmFwZeGoxCvQv5eWP/hOgkKUbZxCH77QAU/IIt6BLhWTnNTPWArTqqMGTjYOtRzXOPR/Me8TOOGDSacpFoRA+wQIVL85XtUbZ/jwh1VZuxdcFasvHc=
Message-ID: <441AA6F0.7090002@gmail.com>
Date: Fri, 17 Mar 2006 19:09:20 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: beware <wimille@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: list of instruction for module programming
References: <3fd7d9680603170250o1b7035cfi@mail.gmail.com>
In-Reply-To: <3fd7d9680603170250o1b7035cfi@mail.gmail.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Here is the hint :P

Linux Device Drivers, Third Edition
http://lwn.net/Kernel/LDD3/

beware wrote:
> Hi,
> i need to create a new module for my training, but i wonder if the
> classic C instructions (like printf, scanf, puts and more) are
> availables when i do my module.
> 
> I don't think so, but i can be mistaken.
> 
> If it's not, where i can find a good list of the instruction i can use.
> 
> Thanks for your help.
> bye
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEGqbwNWc9T2Wr2JcRAlOgAJ4njli9iAYxN+u1klqKHTtJ3PRr8gCfeLPg
8FjXhY8vdo8++rTYeSedS/w=
=ZboL
-----END PGP SIGNATURE-----
