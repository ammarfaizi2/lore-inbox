Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262486AbTFJMQt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 08:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262497AbTFJMQt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 08:16:49 -0400
Received: from pointblue.com.pl ([62.89.73.6]:24592 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S262486AbTFJMQs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 08:16:48 -0400
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Organization: K4 Labs
To: Diego Calleja =?iso-8859-1?q?Garc=EDa?= <diegocg@teleline.es>,
       Maciej Soltysiak <solt@dns.toxicfilms.tv>
Subject: Re: 2.5.70-mm6
Date: Tue, 10 Jun 2003 13:10:33 +0100
User-Agent: KMail/1.5.2
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
References: <20030607151440.6982d8c6.akpm@digeo.com> <Pine.LNX.4.51.0306091943580.23392@dns.toxicfilms.tv> <20030609232001.3980cb7a.diegocg@teleline.es>
In-Reply-To: <20030609232001.3980cb7a.diegocg@teleline.es>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306101310.37670@gjs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

It is not only ext3 problem, I've got this issue on reiserfs as well. It is 
just coused by schleduer.
Anyway, 2.5.x is now slower than 2.4.21-rc7 about 25% on disc access as well !


- --
Grzegorz Jaskiewicz
K4 Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+5cq9qu082fCQYIgRAj8FAJ9Rmo8q4VYLjrFt0zvtklw+MUFnPQCaA7VA
SzoDJgprNamOpz0qO+HXXKM=
=8FbC
-----END PGP SIGNATURE-----

