Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263527AbTDNQRj (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTDNQRj (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:17:39 -0400
Received: from dsl081-067-005.sfo1.dsl.speakeasy.net ([64.81.67.5]:33504 "EHLO
	renegade") by vger.kernel.org with ESMTP id S263527AbTDNQRg (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 12:17:36 -0400
Date: Mon, 14 Apr 2003 09:29:19 -0700
From: Zack Brown <zbrown@tumblerings.org>
To: linux-kernel@vger.kernel.org
Cc: Matthias Andree <matthias.andree@gmx.de>
Subject: Re: lk-changelog.pl 0.96
Message-ID: <20030414162919.GQ2091@renegade>
References: <20030413104943.433A37EBE4@merlin.emma.line.org> <20030413144218.GB21855@renegade> <20030413162338.GC22268@merlin.emma.line.org> <20030413170951.GC21855@renegade> <20030414154901.GC8125@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414154901.GC8125@merlin.emma.line.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 05:49:01PM +0200, Matthias Andree wrote:
> On Sun, 13 Apr 2003, Zack Brown wrote:
> 
> > Too bad for me, I was hoping to use that data structure as a complete list
> > of email -> name translations for changelog entries. Maybe you could
> > include them anyway as commented out entries in the data structure? That
> > would give your script the added benefit of being harvestable for other
> > purposes, but wouldn't sacrifice the regex speed enhancements.
> 
> How about this patch? Taken from CVS. Have fun,

Perfect! :-)

Thanks a lot,
Zack

-- 
Zack Brown
