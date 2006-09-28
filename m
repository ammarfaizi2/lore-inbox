Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWI1PrR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWI1PrR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 11:47:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030210AbWI1PrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 11:47:17 -0400
Received: from pool-71-254-65-206.ronkva.east.verizon.net ([71.254.65.206]:19908
	"EHLO turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1030258AbWI1PrQ (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 11:47:16 -0400
Message-Id: <200609281547.k8SFl3Au004978@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Seongsu Lee <senux@senux.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: specifying the order of calling kernel functions (or modules)
In-Reply-To: Your message of "Thu, 28 Sep 2006 19:17:24 +0900."
             <20060928101724.GA18635@pooky.senux.com>
From: Valdis.Kletnieks@vt.edu
References: <20060928101724.GA18635@pooky.senux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1159458422_3193P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 28 Sep 2006 11:47:02 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1159458422_3193P
Content-Type: text/plain; charset=us-ascii

On Thu, 28 Sep 2006 19:17:24 +0900, Seongsu Lee said:
> I am a beginner of kernel module programming. I want to
> specify the order of calling functions that I registered
> by EXPORT_SYMBOL(). (or modules)

What problem did you expect to solve by specifying the order?  Phrased
differently, why does the order matter?

--==_Exmh_1159458422_3193P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFG+52cC3lWbTT17ARAvN1AJ9wJB+VkUg+Tjkfynu57onoa/xFrQCcDY0I
9NXuePweL6kKsg3s9GnX588=
=SQym
-----END PGP SIGNATURE-----

--==_Exmh_1159458422_3193P--
