Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265764AbUHFLEL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265764AbUHFLEL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 07:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265768AbUHFLEL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 07:04:11 -0400
Received: from colin2.muc.de ([193.149.48.15]:61445 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265764AbUHFLEJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 07:04:09 -0400
Date: 6 Aug 2004 13:04:08 +0200
Date: Fri, 6 Aug 2004 13:04:08 +0200
From: Andi Kleen <ak@muc.de>
To: "YOSHIFUJI Hideaki / ?$B5HF#1QL@" <yoshfuji@linux-ipv6.org>
Cc: davem@redhat.com, jgarzik@pobox.com, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: block layer sg, bsg
Message-ID: <20040806110408.GA52468@muc.de>
References: <20040804232116.GA30152@muc.de> <20040804.165113.06226042.yoshfuji@linux-ipv6.org> <20040805114917.GC31944@muc.de> <20040805.204637.107575718.yoshfuji@linux-ipv6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040805.204637.107575718.yoshfuji@linux-ipv6.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'd suggest changing XFRM_MSG_xxx things to 64bit-aware structures,
> whose layouts do not change between 64bit mode and 32bit mode.
> Of course, they will come with backward compatibility stuff.
> If you don't mind this, I'd like to take care of this.

If you could take care of it it would be great. 
Althought I'm not sure how to do it without breaking backwards
compatibility.

-Andi
