Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbTEGFGF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 01:06:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262860AbTEGFGF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 01:06:05 -0400
Received: from [195.95.38.160] ([195.95.38.160]:13042 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S262124AbTEGFGE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 01:06:04 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Matthew Harrell 
	<mharrell-dated-1052696888.67fff1@bittwiddlers.com>,
       Matthew Harrell <lists-sender-14a37a@bittwiddlers.com>
Subject: Re: [FIXED 2.5.69] Re: [2.5.67 - 2.5.68] Hangs on pcmcia yenta_socket initialisation
Date: Wed, 7 May 2003 07:19:10 +0200
User-Agent: KMail/1.5.1
Cc: Kernel List <linux-kernel@vger.kernel.org>
References: <200304230747.27579.devilkin-lkml@blindguardian.org> <200305051051.09629.devilkin-lkml@blindguardian.org> <20030506234804.GA22226@bittwiddlers.com>
In-Reply-To: <20030506234804.GA22226@bittwiddlers.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305070719.15765.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 07 May 2003 01:48, Matthew Harrell wrote:
> Was this one you reported - I didn't see this one.

It was the fact that when I booted my system with my 3com cardbus NIC inserted 
in the slot it would oops, giving me a non-working pcmcia/cardbus system.

Booting without the card worked fine, and inserting the card afterwards also 
worked great.

thread is here:

http://marc.theaimsgroup.com/?l=linux-kernel&m=105107713129722&w=2

>
> I still get a hang on any 2.5.50+ kernel when I load yenta and have ACPI
> turned on.  It locks solid about three seconds after loading the module
>

Ah. I don't use ACPI, because well... it caused me more pain than it helped me 
in the past, in both OS' on my system (being Linux and win2k)

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+uJdQpuyeqyCEh60RAv/oAKCAUsots5uqvrL0O3dsrBGVXJ9icwCfQS/c
H6BRfG+uFkYWWsFQL8SJsSs=
=cGpw
-----END PGP SIGNATURE-----

