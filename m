Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265030AbTFLWkK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 18:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265031AbTFLWkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 18:40:10 -0400
Received: from cox.ee.ed.ac.uk ([129.215.80.253]:37298 "EHLO
	postbox.ee.ed.ac.uk") by vger.kernel.org with ESMTP id S265030AbTFLWkF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 18:40:05 -0400
From: Unai Garro Arrazola <Unai.Garro@ee.ed.ac.uk>
Organization: The University of Edinburgh
To: linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
Subject: Re: 2.5.70: Lilo needs patching?
Date: Thu, 12 Jun 2003 23:50:15 +0100
User-Agent: KMail/1.5.9
References: <200306122329.47365.Unai.Garro@ee.ed.ac.uk> <20030612154333.608bca2c.akpm@digeo.com>
In-Reply-To: <20030612154333.608bca2c.akpm@digeo.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306122350.18805.Unai.Garro@ee.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 12 June 2003 23:43, Andrew Morton wrote:
>
> For now you can
>
> a) stop using the ramdisk driver (don't mount it) or
>
> b) manually run `blockdev --flushbufs /dev/hdXX' against the boot
>    partition before rebooting.

Thanks! I'll give it a try.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+6QOnhxDfDIoZlaURAsfFAJkBrSfM1ykjuLUBqmuFqV8jZrMNegCfeayL
WX4A9Y1h8zzJQARYvWJ51KY=
=w8wL
-----END PGP SIGNATURE-----
