Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264679AbTFYRGN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:06:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264670AbTFYRGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:06:13 -0400
Received: from pointblue.com.pl ([62.89.73.6]:24069 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S264694AbTFYRGL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:06:11 -0400
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Organization: K4 Labs
To: Asfand Yar Qazi <email@asfandyar.cjb.net>
Subject: Re: Does a patch exist to override the 2GB vfat limit on 2.4.21?
Date: Wed, 25 Jun 2003 17:48:32 +0100
User-Agent: KMail/1.5.9
Cc: linux-kernel@vger.kernel.org
References: <3EF87637.1090109@asfandyar.cjb.net> <200306241649.11615@gjs> <3EF973A2.6080902@asfandyar.cjb.net>
In-Reply-To: <3EF973A2.6080902@asfandyar.cjb.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200306251748.38452@gjs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wednesday 25 of June 2003 11:04, Asfand Yar Qazi wrote:

> Which version do I need?  I'm using 2.2.5 (compiled using kernel 2.4.18
> headers) on a 2.4.21 system.
2.3.1 is the one i use, i i belive you will have to upgrade to this version to 
handle files over 2G


- -- 
Grzegorz Jaskiewicz
K4 Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE++dJkqu082fCQYIgRAoOAAJ4zC1gjGTkSPLFjvcbAeaT6a3RVjgCfUZGW
zkkGlRwbT3VDZRwit9JnEo8=
=8KHI
-----END PGP SIGNATURE-----
