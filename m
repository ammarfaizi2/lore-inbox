Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264770AbTF0UJp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 16:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264763AbTF0UJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 16:09:45 -0400
Received: from mail59-s.fg.online.no ([148.122.161.59]:38528 "EHLO
	mail59.fg.online.no") by vger.kernel.org with ESMTP id S264770AbTF0UJm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 16:09:42 -0400
From: Svein Ove Aas <svein.ove@aas.no>
To: Bryan Whitehead <driver@jpl.nasa.gov>
Subject: Re: TCP send behaviour leads to cable modem woes
Date: Fri, 27 Jun 2003 22:24:03 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200306272020.57502.svein.ove@aas.no> <3EFCA478.7010404@jpl.nasa.gov>
In-Reply-To: <3EFCA478.7010404@jpl.nasa.gov>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306272224.04335.svein.ove@aas.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

fredag 27. juni 2003, 22:09, skrev Bryan Whitehead:
> Take a look at the wondershaper script.
>
> It's helped my DSL get good rates from home both up and down...
>
> http://lartc.org/wondershaper/

I wrote something like that myself once.
It's a good shaper, but it works by *capping* up/download speeds and 
rearranging the priorities locally, which wouldn't help me a bit.

My problem seems to be the severe burstiness of my connection - read the head 
post for a full explanation.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+/Kfj9OlFkai3rMARAsINAKCCNHifkbI098wUxyzXX8Tp+V9KUgCfbxDR
JUKHOvOjTpXMWZLQ6nw6E4E=
=1x7f
-----END PGP SIGNATURE-----

