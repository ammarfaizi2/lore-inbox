Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUCVQml (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 11:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUCVQmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 11:42:40 -0500
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:43938 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S262100AbUCVQmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 11:42:39 -0500
Date: Mon, 22 Mar 2004 11:41:46 -0500
From: Mike Waychison <Michael.Waychison@Sun.COM>
Subject: Re: File change notification (enhanced dnotify)
In-reply-to: <405F0DFD.2070801@gamemakers.de>
To: rudi@lambda-computing.de
Cc: Horst von Brand <vonbrand@inf.utfsm.cl>, linux-kernel@vger.kernel.org
Message-id: <405F174A.3090706@sun.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <200403221500.i2MF0EI7003024@eeyore.valparaiso.cl>
 <200403221500.i2MF0EI7003024@eeyore.valparaiso.cl>
 <405F0DFD.2070801@gamemakers.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Rüdiger Klaehn wrote:

|
| My original approach assumed that inode numbers were unique, and it
| would have worked with hard links. But I think it is much more important
| to have a mechanism that works for all file systems than to solve the
| problem of hard links.
|

Inode numbers are guaranteed to be unique on a given filesystem other
than for hard links..  Where is this assumption broken otherwise?

Mike Waychison
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAXxdJdQs4kOxk3/MRAjdqAKCIJ20IxRgq0PmBcV7IIKITI9FhRQCggZDm
IvcRYGtqB5ss+jhoLNIj2So=
=J6qR
-----END PGP SIGNATURE-----
