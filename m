Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTEOG0s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 02:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbTEOG0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 02:26:47 -0400
Received: from [195.95.38.160] ([195.95.38.160]:7665 "HELO mail.vt4.net")
	by vger.kernel.org with SMTP id S262400AbTEOG0q convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 02:26:46 -0400
From: DevilKin <devilkin-lkml@blindguardian.org>
To: Nagy Tibor <nagyt@otpbank.hu>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20 Ooops on Dell 6600
Date: Thu, 15 May 2003 08:40:12 +0200
User-Agent: KMail/1.5.1
References: <3EC330D7.8060503@dell633.otpefo.com>
In-Reply-To: <3EC330D7.8060503@dell633.otpefo.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305150840.17732.devilkin-lkml@blindguardian.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 15 May 2003 08:16, Nagy Tibor wrote:
> Hi,
>
> we have a Dell PowerEdge 6600 server (4x1400 MHz multithread Xeon, 4GB
> RAM, SuSe Linux 8.0, 2.4.20 Linux kernel). We have got the attached
> 'Ooops'. What does it mean?

Please run this oops through ksymoops and follow instructions in the REPORTING-BUGS 
file in the kernel source.

Jan
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+wzZOpuyeqyCEh60RAoRCAJ9TfHGsVf0+6KzAj/I4hJ48hy0uoQCaA2D3
VFj3b7H3ehSSjFaQ9FO7GvI=
=yeyV
-----END PGP SIGNATURE-----

