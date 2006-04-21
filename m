Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWDUPUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWDUPUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 11:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWDUPUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 11:20:14 -0400
Received: from nz-out-0102.google.com ([64.233.162.196]:825 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932362AbWDUPUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 11:20:12 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=OVpF1Wfj0cA557EKmoZX9ISklNdxBw2oSoJ2osdqA/RMJkd4P8Pk/0mP3cdqUW2KwUs9WEZaANeEj11obCt9BWoV7jyQ1BvRjreu+tYWbzYSVcxxuAcQYDksj89VRWwyXViKEVdkZAwQOD2n9VyE8iDJ8w6oo7A1Vd4i1+3NWYU=
Message-ID: <4448F9A7.9040803@gmail.com>
Date: Fri, 21 Apr 2006 22:26:31 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5.0.2 (X11/20060308)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?T=F6r=F6k_Edwin?= <edwin@gurde.com>
CC: linux-kernel@vger.kernel.org, fireflier-devel@lists.sourceforge.net
Subject: Re: [RFC] packet/socket owner match (fireflier) using skfilter
References: <200604021240.21290.edwin@gurde.com>
In-Reply-To: <200604021240.21290.edwin@gurde.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Does your module get into below problem?

http://lkml.org/lkml/2006/4/20/132
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESPmnNWc9T2Wr2JcRAnMtAKDZvLH2MRmY/jeW/YW/9UP1fm/xwgCfSZZ/
Qom6TxVirR4HWV9Asc2ZixY=
=xlSu
-----END PGP SIGNATURE-----
