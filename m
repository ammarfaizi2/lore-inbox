Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130265AbQLLXbs>; Tue, 12 Dec 2000 18:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130329AbQLLXbi>; Tue, 12 Dec 2000 18:31:38 -0500
Received: from mail2.uni-bielefeld.de ([129.70.4.90]:25650 "EHLO
	mail.uni-bielefeld.de") by vger.kernel.org with ESMTP
	id <S130265AbQLLXbY>; Tue, 12 Dec 2000 18:31:24 -0500
Date: Tue, 12 Dec 2000 22:59:04 +0000
From: Marc Mutz <Marc@Mutz.com>
Subject: Re: VM problem (2.4.0-test11)
To: Jussi Laako <jussi@jlaako.pp.fi>
Cc: linux-kernel@vger.kernel.org
Message-id: <3A36ADB8.3CE36940@Mutz.com>
Organization: University of Bielefeld - Dep. of Mathematics / Dep. of Physics
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17i10-0001 i586)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en
In-Reply-To: <3A36A163.3F01277D@jlaako.pp.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jussi Laako wrote:
> 
> Hello,
> 
> Would it be possible to implement some VM CPUtime/bandwidth limitation?
> 
<snip>

Just to not miss the obvious: You know about ulimit(3)?

man 3 ulimit
help ulimit (when in bash).

Marc

-- 
Marc Mutz <Marc@Mutz.com>     http://EncryptionHOWTO.sourceforge.net/
University of Bielefeld, Dep. of Mathematics / Dep. of Physics

PGP-keyID's:   0xd46ce9ab (RSA), 0x7ae55b9e (DSS/DH)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
