Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264281AbTDKGH4 (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 02:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbTDKGH4 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 02:07:56 -0400
Received: from [195.95.38.160] ([195.95.38.160]:29678 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S264281AbTDKGHz convert rfc822-to-8bit (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 02:07:55 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: kernel support for non-english user messages
Date: Fri, 11 Apr 2003 08:17:23 +0200
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, Devilkin-lkml@blindguardian.org
References: <3E93A958.80107@si.rr.com> <200304110739.41947.devilkin-lkml@blindguardian.org> <20030411054932.GC10992@conectiva.com.br>
In-Reply-To: <20030411054932.GC10992@conectiva.com.br>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200304110817.30731.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Friday 11 April 2003 07:49, Arnaldo Carvalho de Melo wrote:
> Have you ever tried passing 'quiet' as a cmd line parameter to the kernel
> in the bootloader? If not please try.
>
> Try also 'debug'.
>

I had actually no idea that existed. Sorry about my rather useless posting 
then. Might be interesting to move some of the current dmesg messages to the 
debug stage - some output is really way to detailed to be in the standard 
output...

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD4DBQE+ll33puyeqyCEh60RAglnAJ9gNQHwCO5ZabnHsKnx46xsdKMfJwCWNNrC
rbmZ2A+26NYCIU+k8YU+2Q==
=PuPi
-----END PGP SIGNATURE-----

