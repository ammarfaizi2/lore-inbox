Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132434AbRA1VmT>; Sun, 28 Jan 2001 16:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143630AbRA1VmI>; Sun, 28 Jan 2001 16:42:08 -0500
Received: from wpk-smtp-relay2.cwci.net ([195.44.63.19]:38170 "EHLO
	wpk-smtp-relay.cwci.net") by vger.kernel.org with ESMTP
	id <S132434AbRA1Vlx>; Sun, 28 Jan 2001 16:41:53 -0500
Date: Sun, 28 Jan 2001 21:41:15 +0000 (UTC)
From: Mo McKinlay <mmckinlay@gnu.org>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Renaming lost+found
In-Reply-To: <9523bg$7dc$1@cesium.transmeta.com>
Message-ID: <Pine.LNX.4.30.0101282140210.17985-100000@nvws005.nv.london>
Organization: inter/open Labs
X-URL: http://www.interopen.org/
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Today, H. Peter Anvin (hpa@zytor.com) wrote:

  > Hello people... the original question was: can lost+found be
  > *renamed*, i.e. does the tools (e2fsck &c) use "/lost+found" by name,
  > or by inode?  As far as I know it always uses the same inode number
  > (11), but I don't know if that is anywhere enforced.

I seem to recall e2fsck complaining when I renamed lost+found, but that
may well be a consistency check. Don't quote me on this, though.

Mo.

- -- 
Mo McKinlay
mmckinlay@gnu.org
- -------------------------------------------------------------------------
GnuPG/PGP Key: pub  1024D/76A275F9 2000-07-22





-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjp0kgYACgkQRcGgB3aidfngIACdH4Ze9KRUS/jExERYM0Jt0n4e
WyMAoKxzOr7KnVeEoHCHKlCBjNcncx8U
=myDq
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
