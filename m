Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264382AbUEIUGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264382AbUEIUGd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 16:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264384AbUEIUGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 16:06:32 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:28568 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264382AbUEIUGa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 16:06:30 -0400
From: tabris <tabris@tabris.net>
To: "Ernest L. Williams Jr." <ernesto@ornl.gov>
Subject: Re: Issues for  "CONFIG_PREEMPT"
Date: Sun, 9 May 2004 16:06:11 -0400
User-Agent: KMail/1.6.1
Cc: linux-kernel@vger.kernel.org, Robert Love <rml@ximian.com>
References: <1084076781.3424.104.camel@matrix>
In-Reply-To: <1084076781.3424.104.camel@matrix>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200405091606.13567.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 09 May 2004 12:26 am, Ernest L. Williams Jr. wrote:
> Hi,
>
> Please CC me as I am not subscribed to the list.
>
> Are the kernel developers working on the preemptive kernel in 2.6?
>
> Initially the preempt patch was heavily advertised as one of the new
> enhancements for the 2.6 kernel.
>
> What is the current status?  I am not able to find any "detailed"
> information about this.
>
> Could someone please summarize the issues and plans for the preempt
> patch?
I believe the relevant point is that it is no longer a 'patch' but merged in 
mainline 2.6. in fact, it was merged early-mid 2.5 (don't know the precise 
version, didn't pay that much attn).
>
>
Unfortunately for those of us who still like the 2.4 kernel, the Preempt patch  
for 2.4 (previously maintained by Robert Love) is, to my knowledge, no longer 
maintained except by some distros. The official stance is that everybody 
should go with 2.6. And as the preempt patch is not something that can be 
trivially ported/maintained (requiring intimate knowledge of internals), it 
shall likely remain so.
>
> Thanks,
> Ernesto
- --
tabris
- -
Hardware, n.:
	The parts of a computer system that can be kicked.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAno801U5ZaPMbKQcRAg/UAKClO/ZOAS27in6oXxg3AXY2y1Yp0ACgqYbm
kv9RoTF/qiO+GyIyoxKHjlE=
=kyiQ
-----END PGP SIGNATURE-----
