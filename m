Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAZBon>; Thu, 25 Jan 2001 20:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132257AbRAZBoe>; Thu, 25 Jan 2001 20:44:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:58252 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129444AbRAZBo0>;
	Thu, 25 Jan 2001 20:44:26 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14960.54852.630103.360704@pizda.ninka.net>
Date: Thu, 25 Jan 2001 17:43:32 -0800 (PST)
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hotmail not dealing with ECN
In-Reply-To: <3A70D524.11362EFB@transmeta.com>
In-Reply-To: <Pine.LNX.4.21.0101250041440.1498-100000@srv2.ecropolis.com>
	<94qcvm$9qp$1@cesium.transmeta.com>
	<14960.54069.369317.517425@pizda.ninka.net>
	<3A70D524.11362EFB@transmeta.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin writes:
 > Last I communicated with them, I looked for a reference like that in the
 > standards RFCs so I could quote chapter and verse at the Hotmail people,
 > but I couldn't find it.

RFC793, where is lists the unused flag bits as "reserved".
That is pretty clear to me.  It just has to say that
they are reserved, and that is what it does.

 > Right, but there is a whole mythos around which version of IOS does what
 > without breaking something.  I can certainly understand that people are
 > reluctant to upgrade if they don't have to.

As far as I understand it, the PIIX stuff doesn't run IOS but rather
some other system created for these firewall products.

Moot point.  I understand that upgrading can be a pain, but I think
it is in their best interest to do so (see better internet and "make
money" arguments).

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
