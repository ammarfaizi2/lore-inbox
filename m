Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbVBIBRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbVBIBRR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 20:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261729AbVBIBRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 20:17:17 -0500
Received: from host.atlantavirtual.com ([209.239.35.47]:57318 "EHLO
	host.atlantavirtual.com") by vger.kernel.org with ESMTP
	id S261728AbVBIBRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 20:17:12 -0500
Subject: Re: [PATCH 2.4] Wireless Extension v17 (resend)
From: kernel <kernel@crazytrain.com>
Reply-To: kernel@crazytrain.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Jean Tourrilhes <jt@hpl.hp.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20050208184145.GD10799@logos.cnet>
References: <20050208181637.GB29717@bougret.hpl.hp.com>
	 <20050208180116.GA10695@logos.cnet>
	 <20050208215112.GB3290@bougret.hpl.hp.com>
	 <20050208184145.GD10799@logos.cnet>
Content-Type: text/plain
Message-Id: <1107911344.3863.9.camel@crazytrain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 08 Feb 2005 20:09:04 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-02-08 at 13:41, Marcelo Tosatti wrote:
> > 	There need to be some unique features in 2.6.X to force people
> > to upgrade, I guess...
> 
> Faster, cleaner, way more elegant, handles intense loads more gracefully, 
> handles highmem decently, LSM/SELinux, etc, etc...
> 

Please *think* before saying this.  It's not always the case.  Firewire
support in 2.6 kernel has been less than stellar, for one example.  And
yes, for many, solid 1394 support is a requirement for business.

(And we've all seen the testing that has shown both sides (2.4, 2.6)
have been faster)

> IMO everyone should upgrade whenever appropriate. 
> 

Not sure....on 13 January 2005 Alan Cox posted "Given that base 2.6
kernels are shipped by Linus with known unfixed
security holes anyone trying to use them really should be doing some
careful thinking. In truth no 2.6 released kernel is suitable for
anything but beta testing until you add a few patches anyway."

How do you answer this, when telling folks "everyone should upgrade
whenever appropriate."?


Just some random thoughts....from a 2.4 supporter :)

-fd

