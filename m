Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266533AbUBLStz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 13:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266536AbUBLStz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 13:49:55 -0500
Received: from smtp02.web.de ([217.72.192.151]:45855 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S266533AbUBLStx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 13:49:53 -0500
Message-ID: <402BCABE.6050609@web.de>
Date: Thu, 12 Feb 2004 19:49:34 +0100
From: Nils Rennebarth <Nils.Rennebarth@web.de>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040209)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Hemminger <schemminger@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fwd: [Swsusp-devel] Kernel 2.6 pm_send_all() issues.
References: <200402102343.06896.mhf@linuxmail.org> <4029CFAD.9090400@comcast.net>
In-Reply-To: <4029CFAD.9090400@comcast.net>
X-Enigmail-Version: 0.83.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA1671610B1DA58D10B54DFEF"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA1671610B1DA58D10B54DFEF
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Stephen Hemminger wrote:
> I sent them a patch that converts the PCI device to the device model and
> uses suspend/resume hooks.  But they didn't seem to put it in the 
> current version
Could you make the patch publicly available somewhere?

I'm currently using swsusp on 2.6.2 with the XFree86 4.3.0 nv driver
which sort of works, but it lacks 3D of course.


-- 
                                      ______
                                     (Muuuhh)
Global Village Sau  ==>        ^..^ |/¯¯¯¯¯
(Kann Fremdsprache) ==>        (oo)

--------------enigA1671610B1DA58D10B54DFEF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAK8rMqgAZ+sZlgs4RAlo4AKCwoD1fOF3iif/Jb2f26vm3PRQgBQCguWpS
AusMEB6atE/RfjwImzXl4Ag=
=M0sB
-----END PGP SIGNATURE-----

--------------enigA1671610B1DA58D10B54DFEF--
