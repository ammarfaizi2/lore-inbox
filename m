Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263175AbTIVOoT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 10:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTIVOoT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 10:44:19 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:64374 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S263175AbTIVOoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 10:44:17 -0400
Date: Mon, 22 Sep 2003 15:43:45 +0100
From: Dave Jones <davej@redhat.com>
To: CaT <cat@zip.com.au>
Cc: Linus Torvalds <torvalds@osdl.org>, Kronos <kronos@kronoz.cjb.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix Athlon MCA
Message-ID: <20030922144345.GC15344@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, CaT <cat@zip.com.au>,
	Linus Torvalds <torvalds@osdl.org>, Kronos <kronos@kronoz.cjb.net>,
	linux-kernel@vger.kernel.org
References: <20030921143934.GA1867@dreamland.darkstar.lan> <Pine.LNX.4.44.0309211034080.11614-100000@home.osdl.org> <20030921174731.GA891@redhat.com> <20030922142023.GC514@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030922142023.GC514@zip.com.au>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 12:20:23AM +1000, CaT wrote:

 > I don't have my stick of RAM plugged into the first RAM slot but rather
 > the 3rd of 4. I guess this correspends to bank 2 above. I've been ignoring
 > them uptil now but is this a linux hassle or a h/w one?

The bank is referring to an MCE bank rather than a memory slot.
Each MCE bank checks different things.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
