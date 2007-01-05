Return-Path: <linux-kernel-owner+w=401wt.eu-S1161071AbXAEMdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161071AbXAEMdn (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 07:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161077AbXAEMdn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 07:33:43 -0500
Received: from smtp-02.mandic.com.br ([200.225.81.133]:47790 "EHLO
	smtp-02.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161071AbXAEMdm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 07:33:42 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 07:33:42 EST
Message-ID: <459E4455.8050704@mandic.com.br>
Date: Fri, 05 Jan 2007 10:28:05 -0200
From: "Renato S. Yamane" <renatoyamane@mandic.com.br>
User-Agent: Thunderbird 1.5.0.9 (X11/20060911)
MIME-Version: 1.0
To: Akula2 <akula2.shark@gmail.com>
CC: Auke Kok <sofar@foo-projects.org>, linux-kernel@vger.kernel.org
Subject: Re: Multi kernel tree support on the same distro?
References: <8355959a0701041146v40da5d86q55aaa8e5f72ef3c6@mail.gmail.com>	 <459D9872.8090603@foo-projects.org>	 <tekrp2tqo78uh6g2pjmrhe0vpup8aalpmg@4ax.com>	 <459DFE9F.9050904@foo-projects.org> <8355959a0701050404t46ff7c56i52737051b8725c74@mail.gmail.com>
In-Reply-To: <8355959a0701050404t46ff7c56i52737051b8725c74@mail.gmail.com>
X-Enigmail-Version: 0.94.1.1
OpenPGP: id=D420515A;
	url=http://pgp.mit.edu
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Em 05-01-2007 10:04, Akula2 escreveu:
> On 1/5/07, Auke Kok <sofar@foo-projects.org> wrote:
>> Steve Brueggeman wrote:
>> gcc 3.4.x works great on both 2.6 and 2.4, no issues whatsoever.
> 
> Do you mean I need to discard gcc 4.1.x on the distro? Or keep both?

I use GCC 4.1.2 with vendor Kernel (OpenSuSE) 2.6.18.2 with no problem.
In next weekend I will compile a new Kernel. 2.6.19.1

- --
Renato S. Yamane
Fingerprint: 68AE A381 938A F4B9 8A23  D11A E351 5030 D420 515A
PGP Server: http://pgp.mit.edu/ --> KeyID: 0xD420515A
<http://www.renatoyamane.com>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iD8DBQFFnkRV41FQMNQgUVoRAgPVAJ958dCTNmKUDaxIj/uFkc4esHC30wCdFHs4
Vk6doj/x9lnT3jwgaGkcfCA=
=2ELR
-----END PGP SIGNATURE-----
