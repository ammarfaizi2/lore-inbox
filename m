Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263013AbTEBQuK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 12:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbTEBQuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 12:50:09 -0400
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:31403
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S263013AbTEBQuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 12:50:09 -0400
Message-ID: <3EB2A468.6050602@redhat.com>
Date: Fri, 02 May 2003 10:01:28 -0700
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030501
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nat Ersoz <nat.ersoz@myrio.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: strsep() question/modification
References: <1051890980.20514.32.camel@ersoz.et.myrio.com>
In-Reply-To: <1051890980.20514.32.camel@ersoz.et.myrio.com>
X-Enigmail-Version: 0.75.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Nat Ersoz wrote:

> strsep() looks a bit busted to to me.

It is not.  This is the expected behavior.

- -- 
- --------------.                        ,-.            444 Castro Street
Ulrich Drepper \    ,-----------------'   \ Mountain View, CA 94041 USA
Red Hat         `--' drepper at redhat.com `---------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+sqRo2ijCOnn/RHQRAsu8AJwNb8TS3uWcc7YZcEc61PNsMKjyFQCgr41w
AROeQLbWcywNV78cgKJPOvw=
=vk1s
-----END PGP SIGNATURE-----

