Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271335AbTHDALZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 20:11:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271336AbTHDALZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 20:11:25 -0400
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:39856 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S271335AbTHDALX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 20:11:23 -0400
From: "Bryan D. Stine" <admin@kentonet.net>
Organization: KentoNET Communications
To: Russell Whitaker <russ@ashlandhome.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2-bk3
Date: Sun, 3 Aug 2003 20:11:11 -0400
User-Agent: KMail/1.5.3
References: <Pine.LNX.4.53.0308031641270.127@bigred.russwhit.org>
In-Reply-To: <Pine.LNX.4.53.0308031641270.127@bigred.russwhit.org>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308032011.16699.admin@kentonet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Are you using the module-init-tools package? Normal modutils won't work with 
kernel 2.6.

On Sunday 03 August 2003 07:45 pm, Russell Whitaker wrote:
> Hi
>
> Durring boot I get:
>
>   modprobe: QM_MODULES: function not implemented
>
> Hopes this helps
>   Russ
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

- -- 
Bryan D. Stine

GPG Key: 56E8B7A3 / 
http://pgp.mit.edu:11371/pks/lookup?op=get&search=0x56E8B7A3

Key Fingerprint: 96B1 E668 71F8 201A AA80  128E E027 6AFD 56E8 B7A3
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/LaSh4Cdq/Vbot6MRAm3VAJ9JQOD3zxMRPr4/LMBhNQefvvmO6ACdGf7A
8DW3zgJqclJlwDEqvo1/Gnw=
=Lc0l
-----END PGP SIGNATURE-----

