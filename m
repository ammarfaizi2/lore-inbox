Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263340AbUEBWdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbUEBWdO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 18:33:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263348AbUEBWdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 18:33:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:32242 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263340AbUEBWdM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 18:33:12 -0400
From: Patrick Dreker <patrick@dreker.de>
To: Niel Lambrechts <antispam@absamail.co.za>
Subject: Re: [BUG 2.6.6-rc2-mm1] rmmod processor causes kernel panic on speedstep-centrino
Date: Mon, 3 May 2004 00:32:46 +0200
User-Agent: KMail/1.6.2
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <1083532317.18059.12.camel@localhost> <200405030111.56469.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200405030111.56469.vda@port.imtp.ilyichevsk.odessa.ua>
X-message-flag: Please send plain text messages only. Thank you.
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405030032.47808.patrick@dreker.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:55d40479e9cc6e4ab087ddd2b9b4bce4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am Montag, 3. Mai 2004 00:11 schrieb Denis Vlasenko:
> On Monday 03 May 2004 00:11, Niel Lambrechts wrote:
> > EIP:    0060:[<e19db3e6>]    Tainted: PF  VLI
> You are using binary only modules. Please ask authors for help.
Alternatively: reboot your system without *any* binary/non-GPL drivers and 
check if the problem still occurs. If yes, report back...

Patrick
- -- 
Patrick Dreker

GPG KeyID  : 0xFCC2F7A7 (Patrick Dreker)
Fingerprint: 7A21 FC7F 707A C498 F370  1008 7044 66DA FCC2 F7A7
Key available from keyservers
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAlXcOcERm2vzC96cRAgIKAJ9r+Y88pFzB67sIp2rk9BHjdK7XaACfUCci
aPrVXgy1OacoIbYduJhzQQc=
=2Lxc
-----END PGP SIGNATURE-----
