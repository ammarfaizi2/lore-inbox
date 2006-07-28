Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161164AbWG1P7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161164AbWG1P7M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 11:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752024AbWG1P7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 11:59:12 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:40860 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1752016AbWG1P7L (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 11:59:11 -0400
Message-Id: <200607281557.k6SFvn09022794@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Shem Multinymous <multinymous@gmail.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
In-Reply-To: Your message of "Fri, 28 Jul 2006 18:38:13 +0300."
             <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com>
From: Valdis.Kletnieks@vt.edu
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com> <20060727232427.GA4907@suse.cz> <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com> <20060728074202.GA4757@suse.cz> <20060728122508.GC4158@elf.ucw.cz> <20060728134307.GD29217@suse.cz>
            <41840b750607280838s3678299fm8a5d2b46c5b2af06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1154102269_3484P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 28 Jul 2006 11:57:49 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1154102269_3484P
Content-Type: text/plain; charset=us-ascii

On Fri, 28 Jul 2006 18:38:13 +0300, Shem Multinymous said:
>
> Another example: on my ThinkPad, the readouts provided by the EC
> change only every 2 seconds, regardless of how much you poll it.
> 
> Hence my proposal for a polling-based interface with kernel-side
> caching. This way, the hardware query rate is the minimum of two
> rates: what the application can use and what the kernel thinks is the
> hardware's change rate.

Is there a reliable (or hack-worthy) way for the kernel to determine how
often the values are re-posted by the hardware?

--==_Exmh_1154102269_3484P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEyjP9cC3lWbTT17ARAkq6AKD9/vK+FaPluHo2o0/tmEfrBIsXOQCfcKpR
+qD+P4b9eEyK2nPOqAlYtug=
=0V+b
-----END PGP SIGNATURE-----

--==_Exmh_1154102269_3484P--
