Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264039AbTFDUXX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 16:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264040AbTFDUXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 16:23:22 -0400
Received: from pointblue.com.pl ([62.89.73.6]:4114 "EHLO pointblue.com.pl")
	by vger.kernel.org with ESMTP id S264039AbTFDUXW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 16:23:22 -0400
From: Grzegorz Jaskiewicz <gj@pointblue.com.pl>
Organization: K4 Labs
To: "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: sleep forever in ACPI mode S3
Date: Wed, 4 Jun 2003 21:17:48 +0100
User-Agent: KMail/1.5.2
References: <F760B14C9561B941B89469F59BA3A847E96F24@orsmsx401.jf.intel.com>
In-Reply-To: <F760B14C9561B941B89469F59BA3A847E96F24@orsmsx401.jf.intel.com>
Cc: "C. Scott Ananian" <cananian@lesser-magoo.lcs.mit.edu>,
       acpi-support@lists.sourceforge.net, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306042117.52928.gj@pointblue.com.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've got the same problem with my Sony Vaio picturebook PCG-C1VE.
Basicaly after echo 3 >/proc/acpi/sleep laptop turns off instantly. It is dead 
afterwards. It mean that i have to take battery out and stick it in after a 
while to be able to turn it on :/

I don't know why i am not able to suspend this laptop, maybe it lacks such 
facility. Anyway, under windows ME i've been able to do that.

Thanks.

- --
Grzegorz Jaskiewicz
K4 Labs
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+3lPvqu082fCQYIgRAuEYAJsEhV5VkDBxX5UKH/kNTWgst18dtgCghV/B
3jWhD/tWbaMreDaY4hUrvy0=
=UKF2
-----END PGP SIGNATURE-----

