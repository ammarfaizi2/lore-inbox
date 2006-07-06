Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030255AbWGFQif@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWGFQif (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 12:38:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030245AbWGFQif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 12:38:35 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:57045 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030233AbWGFQie (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 12:38:34 -0400
Message-Id: <200607061637.k66Gbu0W008877@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Arjan van de Ven <arjan@infradead.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       kmannth@gmail.com, linux-kernel@vger.kernel.org, mingo@elte.hu,
       tglx@linutronix.de, Natalie.Protasevich@UNISYS.com
Subject: Re: 2.6.17-mm6
In-Reply-To: Your message of "Thu, 06 Jul 2006 09:31:15 +0200."
             <1152171075.3084.12.camel@laptopd505.fenrus.org>
From: Valdis.Kletnieks@vt.edu
References: <20060703030355.420c7155.akpm@osdl.org> <a762e240607051447x3c3c6e15k9cdb38804cf13f35@mail.gmail.com> <20060705155037.7228aa48.akpm@osdl.org> <a762e240607051628n42bf3b79v34178c7251ad7d92@mail.gmail.com> <20060705164457.60e6dbc2.akpm@osdl.org> <20060705164820.379a69ba.akpm@osdl.org> <a762e240607051705h33952e5elf6bd09c1ccea8ab4@mail.gmail.com> <20060705172545.815872b6.akpm@osdl.org> <m1u05v2st3.fsf@ebiederm.dsl.xmission.com> <20060705225905.53e61ca0.akpm@osdl.org> <20060705233123.dcb0a10b.akpm@osdl.org> <m17j2r2od0.fsf@ebiederm.dsl.xmission.com>
            <1152171075.3084.12.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1152203876_2882P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 06 Jul 2006 12:37:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1152203876_2882P
Content-Type: text/plain; charset=us-ascii

On Thu, 06 Jul 2006 09:31:15 +0200, Arjan van de Ven said:
> On Thu, 2006-07-06 at 01:18 -0600, Eric W. Biederman wrote:
w
> > Yes.  Although at least part of that display is per architecture
> > so we may be able to get away with a little more.
> 
> irqbalance uses the per column data for it's work.. please don't kill
> the information or format.

Does irqbalance have a snowball's chance of doing anything sane on the
moby-CPU moby-IRQ boxes under discussion here?  How well does it do when
faced with 10K IRQs on 1K CPUs?

--==_Exmh_1152203876_2882P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFErTxjcC3lWbTT17ARAp2EAKD0BaWr0MktuTrPh/7KuDbiN+mpJwCfX+vh
2lquEkjOQ6IOcRuYQuMGauI=
=F627
-----END PGP SIGNATURE-----

--==_Exmh_1152203876_2882P--
