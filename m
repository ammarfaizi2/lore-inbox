Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751260AbWDTXNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751260AbWDTXNU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWDTXNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:13:20 -0400
Received: from wproxy.gmail.com ([64.233.184.228]:4124 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751260AbWDTXNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:13:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:organization:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=EBn9OvQ85/2CCd+8tlnEQ/3QFmHDCgtyUk9GMqWjZEtu1R82ALgH/RFvofiCAK6X5x3GwOdG1bPwdSq3FoL1Go9JHpwUy4qbPPBMsmV00KtXjo9T29isdjYvjzW7/R5POCWmyf6cEbte6FvRJYCmd/pBZGeWWQKMc7NtGN506Ac=
Message-ID: <44481713.5000309@gmail.com>
Date: Fri, 21 Apr 2006 06:19:47 +0700
From: Mikado <mikado4vn@gmail.com>
Reply-To: mikado4vn@gmail.com
Organization: IcySpace.net
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Which process is associated with process ID 0 (swapper)
References: <4447A19E.9000008@gmail.com> <Pine.LNX.4.61.0604201118200.5749@chaos.analogic.com> <4447B110.4080700@gmail.com> <Pine.LNX.4.61.0604210007140.28841@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0604210007140.28841@yvahk01.tjqt.qr>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=65ABD897
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Jan Engelhardt wrote:
> Is your code doing it like ipt_owner does?

Something like that. When I receive packet info, I'll take PID by
attracting current->pid
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFESBcTNWc9T2Wr2JcRAuZcAJwKhY0vjUCxLGpqkkWOjBgnxj9MpQCgrxGu
li8yXqS6hFTiRYW2MuCBwxI=
=jfmh
-----END PGP SIGNATURE-----
