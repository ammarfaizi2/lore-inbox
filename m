Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264874AbUBIHVl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 02:21:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264936AbUBIHVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 02:21:41 -0500
Received: from khan.acc.umu.se ([130.239.18.139]:24280 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S264874AbUBIHVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 02:21:40 -0500
Date: Mon, 9 Feb 2004 08:21:38 +0100
From: David Weinehall <david@southpole.se>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
Message-ID: <20040209072137.GU5776@khan.acc.umu.se>
Mail-Followup-To: "H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org
References: <c07c67$vrs$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c07c67$vrs$1@terminus.zytor.com>
User-Agent: Mutt/1.4.1i
X-Accept-Language: Swedish, English
X-GPG-Fingerprint: 7ACE 0FB0 7A74 F994 9B36  E1D1 D14E 8526 DC47 CA16
X-GPG-Key: http://www.acc.umu.se/~tao/files/pubkey_dc47ca16.gpg.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 07:17:27AM +0000, H. Peter Anvin wrote:
> Hi all,
> 
> Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?  I'm
> thinking of restructuring the pty system slightly to make it more
> dynamic and to make use of the new larger dev_t, and I'd like to get
> rid of the BSD ptys as part of the same patch.

As long as you make it a 2.7-thing, I don't thing anyone would mind
much...


Regards: David Weinehall
-- 
 /) David Weinehall <tao@acc.umu.se> /) Northern lights wander      (\
//  Maintainer of the v2.0 kernel   //  Dance across the winter sky //
\)  http://www.acc.umu.se/~tao/    (/   Full colour fire           (/
