Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264224AbTCXObd>; Mon, 24 Mar 2003 09:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264225AbTCXObd>; Mon, 24 Mar 2003 09:31:33 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:56547 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S264224AbTCXObc>; Mon, 24 Mar 2003 09:31:32 -0500
Date: Mon, 24 Mar 2003 14:42:27 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: J?rn Engel <joern@wohnheim.fh-wedel.de>,
       James Bourne <jbourne@hardrock.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Ptrace hole / Linux 2.2.25
Message-ID: <20030324144219.GC29637@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	"H. Peter Anvin" <hpa@zytor.com>,
	J?rn Engel <joern@wohnheim.fh-wedel.de>,
	James Bourne <jbourne@hardrock.org>,
	lkml <linux-kernel@vger.kernel.org>
References: <3E7E4C63.908@gmx.de> <Pine.LNX.4.44.0303231717390.19670-100000@cafe.hardrock.org> <20030324003946.GA11081@wohnheim.fh-wedel.de> <3E7E736D.4020200@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E7E736D.4020200@zytor.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 23, 2003 at 06:54:37PM -0800, H. Peter Anvin wrote:
 > >Looks good. Now all that is missing is a link from www.kernel.org,
 > >maybe. Peter, what do you think?
 > I'd rather keep the collection itself on kernel.org.

Another possibility just occured to me.
It'd be useful to add a feature that adds a check to the
build process..

"Download post-release errata ? [Y/n]"

and have it wget patches from k.o, verify signatures and auto-apply them,
which removes the "admin didnt even know there were patches
that needed to be applied" possibility.

		Dave

