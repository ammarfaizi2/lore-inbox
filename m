Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268767AbUHZLsK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268767AbUHZLsK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268685AbUHZLjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:39:16 -0400
Received: from levante.wiggy.net ([195.85.225.139]:24223 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S268802AbUHZLdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:33:38 -0400
Date: Thu, 26 Aug 2004 13:33:32 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Spam <spam@tnonline.net>
Cc: Christer Weinigel <christer@weinigel.se>, Andrew Morton <akpm@osdl.org>,
       jra@samba.org, torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826113332.GL2612@wiggy.net>
Mail-Followup-To: Spam <spam@tnonline.net>,
	Christer Weinigel <christer@weinigel.se>,
	Andrew Morton <akpm@osdl.org>, jra@samba.org, torvalds@osdl.org,
	reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, flx@namesys.com,
	reiserfs-list@namesys.com
References: <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com> <20040825234629.GF2612@wiggy.net> <1939276887.20040826114028@tnonline.net> <20040826024956.08b66b46.akpm@osdl.org> <839984491.20040826122025@tnonline.net> <m3llg2m9o0.fsf@zoo.weinigel.se> <1906433242.20040826133511@tnonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1906433242.20040826133511@tnonline.net>
User-Agent: Mutt/1.5.6+20040523i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Spam wrote:
>   How  so?  The whole idea is that the underlaying OS that handles the
>   copying  should  also  know  to  copy  everything, otherwise you can
>   implement  everything  into  applications  and  just  skip the whole
>   filesystem part.

UNIX doesn't have a copy systemcall, applications copy the data
manually.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
