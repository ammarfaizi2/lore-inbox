Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264912AbRFUKz5>; Thu, 21 Jun 2001 06:55:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264918AbRFUKzr>; Thu, 21 Jun 2001 06:55:47 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:46154 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S264916AbRFUKzm>; Thu, 21 Jun 2001 06:55:42 -0400
Date: Thu, 21 Jun 2001 11:55:40 +0100
From: Tim Waugh <twaugh@redhat.com>
To: Balbir Singh <balbir_soni@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Is it useful to support user level drivers
Message-ID: <20010621115540.Q7663@redhat.com>
In-Reply-To: <20010621104132.91801.qmail@web13609.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="4WLROc9L6mqjEZ7t"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010621104132.91801.qmail@web13609.mail.yahoo.com>; from balbir_soni@yahoo.com on Thu, Jun 21, 2001 at 03:41:32AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4WLROc9L6mqjEZ7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 21, 2001 at 03:41:32AM -0700, Balbir Singh wrote:

> I realize that the Linux kernel supports user level drivers (via
> ioperm, etc). However interrupts at user level are not supported,
> does anyone think it would be a good idea to add user level
> interrupt support ? I have a framework for it, but it still needs a
> lot of work.

Well, for parallel port devices, take a look at libieee1284 and
/dev/parport0.

Tim.
*/

--4WLROc9L6mqjEZ7t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7MdKrONXnILZ4yVIRAmmfAJ9fEop2RGqI4W4bDrEuPtuC2AWbVACdEPXJ
Rs//3q3EgAti6Td8DdUk7Zg=
=E3lA
-----END PGP SIGNATURE-----

--4WLROc9L6mqjEZ7t--
