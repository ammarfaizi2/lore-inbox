Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265255AbUHHLV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUHHLV1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Aug 2004 07:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265256AbUHHLV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Aug 2004 07:21:27 -0400
Received: from server02.akkaya.de ([213.168.83.203]:10517 "EHLO
	server02.akkaya.de") by vger.kernel.org with ESMTP id S265255AbUHHLV0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Aug 2004 07:21:26 -0400
From: Juergen Pabel <jpabel@akkaya.de>
To: Eric Lammerts <eric@lammerts.org>
Subject: Re: [PATCH] Masking kernel commandline parameters (2.6.7)
Date: Sun, 8 Aug 2004 13:21:06 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200408080413.29905.jpabel@akkaya.de> <Pine.LNX.4.58.0408072238570.22657@vivaldi.madbase.net>
In-Reply-To: <Pine.LNX.4.58.0408072238570.22657@vivaldi.madbase.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200408081321.20571.jpabel@akkaya.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 08 August 2004 04:44, Eric Lammerts wrote:
> That would make that ugly kernel patch pointless, wouldn't it? Then
> why bother with it?

Not if the authentication yields the key that will be passed (as a 
hidden/secret) parameter to the boot kernel...

jp
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBFgyqz6J7R+QJGuwRAqGmAJ4gcz13sdtzlTag4VSXa6hIk45qaQCaA+ya
KX9zGZE4FHEHlJ99GNVqm0k=
=WJ5a
-----END PGP SIGNATURE-----
