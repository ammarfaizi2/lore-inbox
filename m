Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261956AbTLHUUc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 15:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261950AbTLHUUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 15:20:32 -0500
Received: from quake.mweb.co.za ([196.2.45.76]:43215 "EHLO quake.mweb.co.za")
	by vger.kernel.org with ESMTP id S261881AbTLHUU3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 15:20:29 -0500
Date: Mon, 8 Dec 2003 22:22:35 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: weifei <weifeil@usc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:can't load module "ide-cd" automatically(2.6.0-test10)
Message-Id: <20031208222235.7f2f09fb.bonganilinux@mweb.co.za>
In-Reply-To: <004801c3bdba$45169360$12087d80@eagle>
References: <009d01c3bcfa$e409a8b0$0300a8c0@tiger>
	<20031207221328.4220ea00.bonganilinux@mweb.co.za>
	<004801c3bdba$45169360$12087d80@eagle>
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Mon__8_Dec_2003_22_22_35_+0200_cAnEWxdomd6p3D4Q"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__8_Dec_2003_22_22_35_+0200_cAnEWxdomd6p3D4Q
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__8_Dec_2003_22_22_35_+0200_MowoSGUtGJyHtKNy"


--Multipart=_Mon__8_Dec_2003_22_22_35_+0200_MowoSGUtGJyHtKNy
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 08 Dec 2003 10:37:01 -0800
weifei <weifeil@usc.edu> wrote:

> 
> 
> No file named /etc/modprobe.preload and no manual for this file. Sould you
> please tell me where to find manual for it?
> Thanks
> 

On my Mandrake Cooker box I have it I've attached a copy which I only use to load the bttv driver. The comments should explain how to use this file.

--Multipart=_Mon__8_Dec_2003_22_22_35_+0200_MowoSGUtGJyHtKNy
Content-Type: application/octet-stream;
 name="acpish.conf"
Content-Disposition: attachment;
 filename="acpish.conf"
Content-Transfer-Encoding: base64

Iy0qLW1vZGU6IHNoLSotCiMgQ29uZmlndXJhdGlvbiBvZiBhY3BpIHNjcmlwdAojCgojIFBvd2Vy
IGJ1dHRvbiBhY3Rpb24KIyBEZWZhdWx0OiAiYmFzaCAtYyBcImlmICEgeG1lc3NhZ2UgLWZvbnQg
aHVnZSAtdGltZW91dCAzMCAtYnV0dG9ucyBDYW5jZWw6MCxIYWx0OjEgLWRlZmF1bHQgQ2FuY2Vs
IC1nZW9tZXRyeSArNTAwKzM4MCAnSGFsdCBjb21wdXRlciA/Jzt0aGVuIC9zYmluL3NodXRkb3du
IC1oIC1rIG5vdyAnUG93ZXIgYnV0dG9uJzsgc2xlZXAgMTA7IC9zYmluL3NodXRkb3duIC1oIC1r
IC10IDUgbm93ICdIYWx0aW5nIG1hY2hpbmUnOyBmaVwiICYiClBPV0VSX0JVVFRPTl9BQ1RJT049
ImJhc2ggLWMgXCJpZiAhIHhtZXNzYWdlIC1mb250IGh1Z2UgLXRpbWVvdXQgMzAgLWJ1dHRvbnMg
Q2FuY2VsOjAsSGFsdDoxIC1kZWZhdWx0IENhbmNlbCAtZ2VvbWV0cnkgKzUwMCszODAgJ0hhbHQg
Y29tcHV0ZXIgPyc7dGhlbiAvc2Jpbi9zaHV0ZG93biAtaCAtayBub3cgJ1Bvd2VyIGJ1dHRvbic7
IHNsZWVwIDEwOyAvc2Jpbi9zaHV0ZG93biAtaCAtdCA1IG5vdyAnSGFsdGluZyBtYWNoaW5lJzsg
ZWxpZiAhIHhtZXNzYWdlIC1mb250IGh1Z2UgLXRpbWVvdXQgMzAgLWJ1dHRvbnMgQ2FuY2VsOjAs
U3RvcDoxIC1kZWZhdWx0IENhbmNlbCAtZ2VvbWV0cnkgKzUwMCszODAgJ1N0b3AgQUNQSSBtb25p
dG9yaW5nID8nO3RoZW4ga2lsbCAkJDsgZmlcIiAmIgoKIyBMaWQgY2xvc2luZyBhY3Rpb24KIyBE
ZWZhdWx0OiAiL3Vzci9sb2NhbC9zYmluL2hpYmVybmF0ZSIKTElEX0FDVElPTj0iL3Vzci9sb2Nh
bC9zYmluL2hpYmVybmF0ZSIK

--Multipart=_Mon__8_Dec_2003_22_22_35_+0200_MowoSGUtGJyHtKNy
Content-Type: application/octet-stream;
 name="modprobe.preload"
Content-Disposition: attachment;
 filename="modprobe.preload"
Content-Transfer-Encoding: base64

IyAvZXRjL21vZHByb2JlLnByZWxvYWQ6IGtlcm5lbCBtb2R1bGVzIHRvIGxvYWQgYXQgYm9vdCB0
aW1lLgojCiMgVGhpcyBmaWxlIHNob3VsZCBjb250YWluIHRoZSBuYW1lcyBvZiBrZXJuZWwgbW9k
dWxlcyB0aGF0IGFyZQojIHRvIGJlIGxvYWRlZCBhdCBib290IHRpbWUsIG9uZSBwZXIgbGluZS4g
IENvbW1lbnRzIGJlZ2luIHdpdGgKIyBhIGAjJywgYW5kIGV2ZXJ5dGhpbmcgb24gdGhlIGxpbmUg
YWZ0ZXIgdGhlbSBhcmUgaWdub3JlZC4KIyB0aGlzIGZpbGUgaXMgZm9yIG1vZHVsZS1pbml0LXRv
b2xzIChrZXJuZWwgMi41IGFuZCBhYm92ZSkgT05MWQojIGZvciBvbGQga2VybmVsIHVzZSAvZXRj
L21vZHVsZXMKCmJ0dHYK

--Multipart=_Mon__8_Dec_2003_22_22_35_+0200_MowoSGUtGJyHtKNy--

--Signature=_Mon__8_Dec_2003_22_22_35_+0200_cAnEWxdomd6p3D4Q
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/1N2S+pvEqv8+FEMRAipDAKCZgBoY6U44opYk3kiftjgCGdx7mQCeK2NI
8/NWf6MkumCeYLFpP6IxF68=
=doBJ
-----END PGP SIGNATURE-----

--Signature=_Mon__8_Dec_2003_22_22_35_+0200_cAnEWxdomd6p3D4Q--
