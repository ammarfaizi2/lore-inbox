Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264812AbUD1OOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264812AbUD1OOM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264789AbUD1OOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:14:11 -0400
Received: from jurassic.park.msu.ru ([195.208.223.243]:37516 "EHLO
	jurassic.park.msu.ru") by vger.kernel.org with ESMTP
	id S264819AbUD1OKJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:10:09 -0400
Date: Wed, 28 Apr 2004 18:09:01 +0400
From: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
To: Dru <andru@treshna.com>
Cc: Marc Giger <gigerstyle@gmx.ch>,
       =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: status of Linux on Alpha?
Message-ID: <20040428180901.A18214@jurassic.park.msu.ru>
References: <20040329205233.5b7905aa@vaio.gigerstyle.ch> <20040404121032.7bb42b35@vaio.gigerstyle.ch> <20040409134534.67805dfd@vaio.gigerstyle.ch> <20040409134828.0e2984e5@vaio.gigerstyle.ch> <20040409230651.A727@den.park.msu.ru> <20040413194907.7ce8ceb7@vaio.gigerstyle.ch> <20040427185124.134073cd@vaio.gigerstyle.ch> <20040427215514.A651@den.park.msu.ru> <20040427200830.3f485a54@vaio.gigerstyle.ch> <408FADE8.6090705@treshna.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <408FADE8.6090705@treshna.com>; from andru@treshna.com on Thu, Apr 29, 2004 at 01:13:12AM +1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 01:13:12AM +1200, Dru wrote:
> I did notice one other very minor issue, which was if i set it the alpha
> system type to Nautilus instead of generic it doesnt boot.
> It cycles lost interupt when detecting drives, it doesnt time out (each lost
> intrupt times out but it keeps looking continally). 

Strange. My UP1500 boots just fine with nautilus specific kernel.
Can you send me your .config?

Ivan.
