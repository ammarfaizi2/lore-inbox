Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264605AbUBILGg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 06:06:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbUBILGg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 06:06:36 -0500
Received: from [193.170.124.123] ([193.170.124.123]:38978 "EHLO 23.cms.ac")
	by vger.kernel.org with ESMTP id S264605AbUBILGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 06:06:34 -0500
Date: Mon, 9 Feb 2004 12:06:24 +0100
From: JG <jg@cms.ac>
To: John Bradford <john@grabjohn.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: could someone plz explain those ext3/hard disk errors
In-Reply-To: <200402091026.i19AQ15t000678@81-2-122-30.bradfords.org.uk>
References: <20040208175346.767881A96E1@23.cms.ac>
	<20040209014722.GA22683@stout.hampshire.edu>
	<20040209095227.AF4261A9ACF@23.cms.ac>
	<200402091026.i19AQ15t000678@81-2-122-30.bradfords.org.uk>
X-Mailer: Sylpheed version 0.9.9claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Gentoo 1.4 ;)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__9_Feb_2004_12_06_25_+0100_q9z+3PO0WhqzGXc7"
Message-Id: <20040209110633.1E8DE1A9AD7@23.cms.ac>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__9_Feb_2004_12_06_25_+0100_q9z+3PO0WhqzGXc7
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

hi,

> Please read the FAQ, fix your mail application - you are sending long
> lines, and don't break the CC list.

i've re-read it now, but i'm sorry, i don't know what you mean with "don't break the CC list".
the long lines were my mistake.


> As to your problem, look at the LBA sector addresses in the error
> message:
> 
> 280923064991615
> 
> is your drive really over 100 EB?  No...

i know this value can't be right, but why does such a problem arise? is it the raid-controller's driver or bios? or something else?

thx,
JG


--Signature=_Mon__9_Feb_2004_12_06_25_+0100_q9z+3PO0WhqzGXc7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAJ2m4U788cpz6t2kRAsU3AJ4oawz5No4SQwx7CEZN4OGXafP8cgCeIgPJ
OQBiXN+Wi4LoIuwuDkbud6o=
=A2/U
-----END PGP SIGNATURE-----

--Signature=_Mon__9_Feb_2004_12_06_25_+0100_q9z+3PO0WhqzGXc7--
