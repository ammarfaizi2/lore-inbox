Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbSKVKXy>; Fri, 22 Nov 2002 05:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262905AbSKVKXy>; Fri, 22 Nov 2002 05:23:54 -0500
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:8876 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S261908AbSKVKXx>; Fri, 22 Nov 2002 05:23:53 -0500
Date: Fri, 22 Nov 2002 08:12:11 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Albert D. Cahalan" <acahalan@cs.uml.edu>, linux-kernel@vger.kernel.org,
       kentborg@borg.org, alan@lxorguk.ukuu.org.uk
Subject: Re: Where is ext2/3 secure delete ("s") attribute?
Message-ID: <20021122081211.Q628@nightmaster.csn.tu-chemnitz.de>
References: <200211220122.gAM1MQY305783@saturn.cs.uml.edu> <3DDD88BB.209@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3DDD88BB.209@pobox.com>; from jgarzik@pobox.com on Thu, Nov 21, 2002 at 08:30:35PM -0500
X-Spam-Score: -2.5 (--)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18FB5R-00079B-00*maRVTP2bIUU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 08:30:35PM -0500, Jeff Garzik wrote:
> Please name a filesystem that moves allocated blocks around on you.  And 
> point to code, too.

TUX2 from Daniel Phillips. No in kernel and might not ever be,
buts a good argument, because there it is by design ;-)

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
