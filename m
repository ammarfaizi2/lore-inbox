Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130127AbQLATKc>; Fri, 1 Dec 2000 14:10:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130147AbQLATKW>; Fri, 1 Dec 2000 14:10:22 -0500
Received: from mail2.uni-bielefeld.de ([129.70.4.90]:3877 "EHLO
	mail.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S130127AbQLATKK>; Fri, 1 Dec 2000 14:10:10 -0500
Date: Fri, 01 Dec 2000 18:38:03 +0000
From: Marc Mutz <Marc@Mutz.com>
Subject: Re: [uPATCH] Re: Questions about Kernel 2.4.0.*
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Android <android@turbosport.com>, linux-kernel@vger.kernel.org
Message-id: <3A27F00B.4A431099@Mutz.com>
Organization: University of Bielefeld - Dep. of Mathematics / Dep. of Physics
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17i10-0001 i586)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
In-Reply-To: <001c01c05a86$45bb6380$19211518@vnnys1.ca.home.com>
 <20001130060732.A14250@wire.cadcamlab.org> <3A27CB48.38A1907C@Mutz.com>
 <14887.60824.271322.811343@wire.cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Samuelson wrote:
> 
<snip>
> +TOPDIR := $(shell pwd -P)
<snip>

That is specific to the bash builtin 'pwd'. GNU sh-util's pwd does not
know that option (at least not my version, which is: "pwd (GNU sh-utils)
1.16")

I just wanted to note that...

Marc

-- 
Marc Mutz <Marc@Mutz.com>     http://EncryptionHOWTO.sourceforge.net/
University of Bielefeld, Dep. of Mathematics / Dep. of Physics

PGP-keyID's:   0xd46ce9ab (RSA), 0x7ae55b9e (DSS/DH)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
