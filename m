Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUHYXsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUHYXsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 19:48:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266467AbUHYXsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 19:48:14 -0400
Received: from levante.wiggy.net ([195.85.225.139]:44425 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S266611AbUHYXqb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 19:46:31 -0400
Date: Thu, 26 Aug 2004 01:46:29 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Jeremy Allison <jra@samba.org>
Cc: Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>, torvalds@osdl.org,
       reiser@namesys.com, hch@lst.de, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040825234629.GF2612@wiggy.net>
Mail-Followup-To: Jeremy Allison <jra@samba.org>,
	Andrew Morton <akpm@osdl.org>, Spam <spam@tnonline.net>,
	torvalds@osdl.org, reiser@namesys.com, hch@lst.de,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, reiserfs-list@namesys.com
References: <20040824202521.GA26705@lst.de> <412CEE38.1080707@namesys.com> <20040825152805.45a1ce64.akpm@osdl.org> <112698263.20040826005146@tnonline.net> <Pine.LNX.4.58.0408251555070.17766@ppc970.osdl.org> <1453698131.20040826011935@tnonline.net> <20040825163225.4441cfdd.akpm@osdl.org> <20040825233739.GP10907@legion.cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040825233739.GP10907@legion.cup.hp.com>
User-Agent: Mutt/1.5.6+20040523i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Jeremy Allison wrote:
> Multiple-data-stream files are something we should offer, definately (IMHO).
> I don't care how we do it, but I know it's something we need as application
> developers.

Aside from samba, is there any other application that has a use for
them? 

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
