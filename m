Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268223AbUIBL2J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268223AbUIBL2J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 07:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268214AbUIBL2J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 07:28:09 -0400
Received: from frankvm.xs4all.nl ([80.126.170.174]:29146 "EHLO
	janus.localdomain") by vger.kernel.org with ESMTP id S268223AbUIBL0Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 07:26:24 -0400
Date: Thu, 2 Sep 2004 13:26:23 +0200
From: Frank van Maarseveen <frankvm@xs4all.nl>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Linus Torvalds <torvalds@osdl.org>, kangur@polcom.net,
       linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040902112623.GA3059@janus>
References: <20040829150231.GE9471@alias> <4132205A.9080505@namesys.com> <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk> <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk> <41323751.5000607@namesys.com> <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org> <Pine.LNX.4.60.0408300009001.10533@alpha.polcom.net> <Pine.LNX.4.58.0408291523130.2295@ppc970.osdl.org> <20040902125156.2dc6fe97.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040902125156.2dc6fe97.skraw@ithnet.com>
User-Agent: Mutt/1.4.1i
X-Subliminal-Message: Use Linux!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02, 2004 at 12:51:56PM +0200, Stephan von Krawczynski wrote:
> 
> I therefore declare as this years hot issue:
> How to use more than 32 GIDs on nfs? Frank van Maarseveens' patch being
                       ^^
The limit for NFS is 16.


> available for years I guess, but with 2.6 supporting lots of GIDs becoming very
> actual...

thank you for reminding me that I still need to port it to 2.6. The patch came
into existence around 2.2.17 IIRC.

-- 
Frank
