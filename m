Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWKBO14@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWKBO14 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:27:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWKBO14
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:27:56 -0500
Received: from lugor.de ([212.112.242.222]:56007 "EHLO solar.mylinuxtime.de")
	by vger.kernel.org with ESMTP id S1750831AbWKBO1z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:27:55 -0500
From: "Hesse, Christian" <mail@earthworm.de>
To: Avi Kivity <avi@qumranet.com>
Subject: Re: [ANNOUNCE] kvm howto
Date: Thu, 2 Nov 2006 15:27:04 +0100
User-Agent: KMail/1.9.4
Cc: kvm-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <4549F1D5.8070509@qumranet.com>
In-Reply-To: <4549F1D5.8070509@qumranet.com>
X-Face: 1\p'dhO'VZk,x0lx6U}!Y*9UjU4n2@4c<"a*K%3Eiu'VwM|-OYs;S-PH>4EdJMfGyycC)=?utf-8?q?k=0A=09=3Anv*xqk4C?=@1b8tdr||mALWpN[2|~h#Iv;)M"O$$#P9Kg+S8+O#%EJx0TBH7b&Q<m)=?utf-8?q?n=23Q=2Eo=0A=09kE=7E=26T=5D0cQX6=5D?=<q!HEE,F}O'Jd#lx/+){Gr@W~J`h7sTS(M+oe5<=?utf-8?q?3O7GY9y=5Fi!qG=26Vv=5CD8/=0A=09=254?=@&~$Z@UwV'NQ$Ph&3fZc(qbDO?{LN'nk>+kRh4`C3[KN`-1uT-TD_m
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3563081.INBlf7cJUB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200611021527.09664.mail@earthworm.de>
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0 (solar.mylinuxtime.de [10.5.1.1]); Thu, 02 Nov 2006 15:27:10 +0100 (CET)
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3563081.INBlf7cJUB
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 02 November 2006 14:25, Avi Kivity wrote:
> I've just uploaded a HOWTO to http://kvm.sourceforge.net, including
> (hopefuly) everything needed to get kvm running.  Please take a look and
> comment.

  CC [M]  /tmp/kvm-module/kvm_main.o
{standard input}: Assembler messages:
{standard input}:168: Error: no such instruction: `vmxon 16(%esp)'
{standard input}:182: Error: no such instruction: `vmxoff'
{standard input}:192: Error: no such instruction: `vmread %eax,%eax'
{standard input}:415: Error: no such instruction: `vmwrite %ebx,%esi'
{standard input}:1103: Error: no such instruction: `vmclear 16(%esp)'
{standard input}:1676: Error: no such instruction: `vmptrld 16(%esp)'
{standard input}:4107: Error: no such instruction: `vmwrite %esp,%eax'
{standard input}:4119: Error: no such instruction: `vmlaunch '
{standard input}:4121: Error: no such instruction: `vmresume '

I get a number of errors compiling the module. No difference between the=20
downloaded tarball and my patched kernel tree. Any hints?
=2D-=20
Regards,
Christian

--nextPart3563081.INBlf7cJUB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFSgA9lZfG2c8gdSURAgSWAJ9uSRK8qV0i75bHxe0ZwOvsZQTapgCfTnaX
If0NuYTq4qv8XteXAx68naA=
=RFgt
-----END PGP SIGNATURE-----

--nextPart3563081.INBlf7cJUB--
