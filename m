Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264535AbUESUW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbUESUW4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 16:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbUESUW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 16:22:56 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:35741 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S264530AbUESUWw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 16:22:52 -0400
Date: Wed, 19 May 2004 15:22:51 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Tobias =?iso-8859-1?Q?Ringstr=F6m?= <tobias@ringstrom.mine.nu>
Cc: linux-kernel@vger.kernel.org, Christophe Saout <christophe@saout.de>
Subject: Re: IPsec/crypto kernel panic in 2.6.[456]
Message-ID: <20040519202251.GA22516@hexapodia.org>
References: <40ABBA0F.5050805@ringstrom.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40ABBA0F.5050805@ringstrom.mine.nu>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 09:48:31PM +0200, Tobias Ringström wrote:
> I get a kernel panic that is very easy to reproduce.  The panic goes 
> away if I revert the following changeset ("fix in-place de/encryption 
> bug with highmem"):
> 
>     http://linux.bkbits.net:8080/linux-2.5/cset@1.1371.476.15

Or,
http://linux.bkbits.net:8080/linux-2.5/cset@40443186BowXpsBHgFbxClLNqkdCyw

(need to use "bookmarkable link"; revision numbers change.)

-andy
