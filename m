Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269751AbUHZWig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269751AbUHZWig (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 18:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266198AbUHZWdX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 18:33:23 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:62475 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S269743AbUHZW3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 18:29:39 -0400
Date: Fri, 27 Aug 2004 00:26:22 +0200
From: Willy Tarreau <willy@w.ods.org>
To: "O.Sezer" <sezeroz@ttnet.net.tr>
Cc: Adrian Bunk <bunk@fs.tum.de>, linux-kernel@vger.kernel.org,
       marcelo.tosatti@cyclades.com
Subject: Re: Linux 2.4.28-pre2
Message-ID: <20040826222622.GD564@alpha.home.local>
References: <412E012F.4050503@ttnet.net.tr> <20040826191501.GA12772@fs.tum.de> <412E3EEB.5010603@ttnet.net.tr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <412E3EEB.5010603@ttnet.net.tr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 10:50:03PM +0300, O.Sezer wrote:
> >They are not a real problem with gcc 3.4, and whether gcc 3.5 will ever 
> >be supported as compiler for kernel 2.4 is a question whose answer lies 
> >far in the future.
> 
> That is a valid point but it'd be sad if gcc3.5 wouldn't be supported.

Tell that to gcc developpers who constantly break compatibility between
versions. I even have userland programs which do not compile anymore with
gcc-3.3 and which I don't even know how to 'fix' (workaround ?).

Cheers,
Willy

