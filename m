Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262932AbUGHQ0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbUGHQ0I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 12:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263159AbUGHQ0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 12:26:08 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:20143 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262932AbUGHQ0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 12:26:00 -0400
Date: Thu, 8 Jul 2004 17:23:57 +0100
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Miles Bader <miles@gnu.org>, "David S. Miller" <davem@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>, chrisw@osdl.org,
       akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
       jmorris@redhat.com, mika@osdl.org
Subject: Re: [PATCH] Use NULL instead of integer 0 in security/selinux/
Message-ID: <20040708162357.GB19685@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Miles Bader <miles@gnu.org>,
	"David S. Miller" <davem@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, chrisw@osdl.org,
	akpm@osdl.org, linux-kernel@vger.kernel.org, sds@epoch.ncsc.mil,
	jmorris@redhat.com, mika@osdl.org
References: <20040707122525.X1924@build.pdx.osdl.net> <E1BiPKz-0008Q7-00@gondolin.me.apana.org.au> <20040707202746.1da0568b.davem@redhat.com> <buo7jtfi2p9.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407072220060.1764@ppc970.osdl.org> <buosmc3gix6.fsf@mctpc71.ucom.lsi.nec.co.jp> <Pine.LNX.4.58.0407080855120.1764@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407080855120.1764@ppc970.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 08:58:18AM -0700, Linus Torvalds wrote:

 > Me, I don't accept the kind of entries the OCC accepts. 

drivers/char/drm/ disagrees 8-)

SCNR

		Dave

