Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132652AbQLQO4j>; Sun, 17 Dec 2000 09:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132666AbQLQO43>; Sun, 17 Dec 2000 09:56:29 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:34979 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S132652AbQLQO4V>; Sun, 17 Dec 2000 09:56:21 -0500
Date: Sun, 17 Dec 2000 14:25:54 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Jani Monoses <jani@virtualro.ic.ro>
Cc: mj@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] pci.c inline documentation
Message-ID: <20001217142554.A22587@redhat.com>
In-Reply-To: <Pine.LNX.4.10.10012161733050.11101-100000@virtualro.ic.ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10012161733050.11101-100000@virtualro.ic.ro>; from jani@virtualro.ic.ro on Sat, Dec 16, 2000 at 05:37:51PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 16, 2000 at 05:37:51PM +0200, Jani Monoses wrote:

> + * Otherwise if @from is not %NULL, searches continue from that point.

Searches continue from the next one I think.

> + * pci_register_driver - register a new pci driver
[...]
> + * pci_unregister_driver - unregister a pci driver
[...]
> + * pci_insert_device - insert a hotplug device
> + * pci_remove_device - remove a hotplug device
> + * pci_dev_driver - get the pci_driver of a device
> + * pci_set_master - enables bus-mastering for device dev
> + * pci_setup_device - fill in class and map information of a device

These have no full-stop after the description, but the others do.

Tim.
*/

--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6PMzxONXnILZ4yVIRAoZ4AJkBSryJUn5Hhd9YF5PGBhdoeRc6EwCcCMaw
gb+hAlElHOiLM4OkuvCjtz4=
=zrfc
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
