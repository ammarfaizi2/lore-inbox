Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266126AbUFIL7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbUFIL7E (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 07:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266134AbUFIL7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 07:59:04 -0400
Received: from mail.eris.qinetiq.com ([128.98.1.1]:21017 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S266126AbUFIL7A convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 07:59:00 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: linux-kernel@vger.kernel.org
Subject: Re: simple sparc32 smp question
Date: Wed, 9 Jun 2004 12:55:59 +0100
User-Agent: KMail/1.6.1
Cc: "Brad Mattick" <bradmattick@yahoo.com>
References: <04f301c44dcb$7441b6a0$6804a8c0@shrike>
In-Reply-To: <04f301c44dcb$7441b6a0$6804a8c0@shrike>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406091255.59578.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> Hi all,
>
> I've checked the outdated faqs, searched through the archives and still
> haven't found an answer to my simple question:
>
> What is the latest stable kernel that I can run on a quad 125 MHz Ross
> HyperSparc SPARCstation 20?
>
> I'm currently running 2.2.22 and it has a kernel oops weekly with all 4
> CPUs installed. With 2 CPUs (either card- I've tested) it runs stable, if
> much slower. Last I checked (back when 2.4 was new) 2.2 was it for sparc32.
> Is this still the case?
>

I've certainly run an SS20 with a 2.4 kernel (2.4.x where x>12) on dual Ross 
HyperSparcs. The initial Gentoo Sparc port IIRC...

Mark.


- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAxvrPBn4EFUVUIO0RAu3BAJsFK544820ceQ2D878IGZQaSpM5pACffhhK
VQFYbiTtCYX94//6v+Qye5o=
=GuXQ
-----END PGP SIGNATURE-----
