Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266230AbUFRQvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266230AbUFRQvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 12:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266217AbUFRQvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 12:51:09 -0400
Received: from cs2416783-242.houston.rr.com ([24.167.83.242]:11744 "EHLO
	crustytoothpaste.ath.cx") by vger.kernel.org with ESMTP
	id S265484AbUFRQui convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 12:50:38 -0400
From: "Brian M\. Carlson" <sandals@crustytoothpaste.ath.cx>
To: debian-legal@lists.debian.org, debian-kernel@lists.debian.org,
       debian-devel@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: How long is it acceptable to leave *undistributable* files in the kernel package?
Date: Fri, 18 Jun 2004 16:50:08 +0000
User-Agent: KMail/1.6.2
References: <o0_liB.A.TFG.4fu0AB@murphy> <20040618113543.B1892@links.magenta.com> <20040618155113.GD1863@holomorphy.com>
In-Reply-To: <20040618155113.GD1863@holomorphy.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406181650.34830.sandals@crustytoothpaste.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----

On Friday 18 June 2004 15:51, William Lee Irwin III wrote:
> On Fri, Jun 18, 2004 at 11:35:43AM -0400, Raul Miller wrote:
> > That clause only deals with some anthology works, not all.  It's an
> > exception to <<a "work based on the Program" means either the Program or
> > any derivative work under copyright law: that is to say, a work
> > containing the Program or a portion of it, either verbatim or with
> > modifications...>> It's pretty clear that the linux kernel is not a mere
> > aggregation of works on some volume of storage.
>
> Any chance you guys could come to some kind of consensus on this so I
> know what has to be done for the debian package?
>
> Thanks.

If it's undistributable, it obviously doesn't belong in main. So please
remove the undistributable stuff. Second, if it's non-free, it doesn't
belong in the kernel, which is in main. So remove anything that is
non-free from the kernel-source. It's really not rocket science, and I
don't know why people insist upon talking about collective versus
derivative works, because none of this stuff belongs in main anyway.

If you need help in determining whether something is free or not, please send 
a message to debian-legal (preferably in a new thread) asking that question.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUBQNMdSOWR/8lWBVPnAQFdPQf+P4lhAJpZ4Em1SByzalfDUQSkBvDoEM3a
YP7mAHV1i3cUWwVM0oWJnvOd2v9ZYmvDFk2VzXFh9SYz2wHnYGE0cs85jiKOtnjo
pItvmhry1/GZDQNVSHnAwX0hUl3K8VF8jWyOwXdYRYxlYYTmTd4tJYlaN9HTomhn
THCBCOF7ZY04qdoC4gslHVJAJm4CVBex6gfRz3O+ExkJC5TO5fT81D+vg+uQOs+N
ITGTI10ZjvmISTkYHaCRuTPwd6+S/AjPozoYzGyNOnVNoydX81VXIvHJtm+6mBuM
v/OmWflwUI0Y39Dm+NestF0HmIdjNMl7pm59V7PBXreldB02feibxQ==
=v2xr
-----END PGP SIGNATURE-----
