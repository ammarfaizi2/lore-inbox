Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264779AbUD1Nat@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264779AbUD1Nat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 09:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264780AbUD1Nat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 09:30:49 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:56842 "EHLO
	ford.pronto.tv") by vger.kernel.org with ESMTP id S264779AbUD1Nar convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 09:30:47 -0400
To: Dru <andru@treshna.com>
Cc: Marc Giger <gigerstyle@gmx.ch>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: status of Linux on Alpha?
References: <20040328204308.C14868@jurassic.park.msu.ru>
	<20040328221806.7fa20502@vaio.gigerstyle.ch>
	<yw1xr7vcn1z2.fsf@ford.guide>
	<20040329205233.5b7905aa@vaio.gigerstyle.ch>
	<20040404121032.7bb42b35@vaio.gigerstyle.ch>
	<20040409134534.67805dfd@vaio.gigerstyle.ch>
	<20040409134828.0e2984e5@vaio.gigerstyle.ch>
	<20040409230651.A727@den.park.msu.ru>
	<20040413194907.7ce8ceb7@vaio.gigerstyle.ch>
	<20040427185124.134073cd@vaio.gigerstyle.ch>
	<20040427215514.A651@den.park.msu.ru>
	<20040427200830.3f485a54@vaio.gigerstyle.ch>
	<408FADE8.6090705@treshna.com>
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Date: Wed, 28 Apr 2004 15:29:43 +0200
In-Reply-To: <408FADE8.6090705@treshna.com> (Dru's message of "Thu, 29 Apr
 2004 01:13:12 +1200")
Message-ID: <yw1xy8ogkz7c.fsf@kth.se>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dru <andru@treshna.com> writes:

> I've tested the patch on high loads and it handles it fine, its even
> still very responsive under those loads (can't say the same for
> my pentium4) Thanks a lot guys.
>
> I'll put it though some more heavier tests over the next few days
> to make certain its rock solid.
>
> I did notice one other very minor issue, which was if i set it the alpha
> system type to Nautilus instead of generic it doesnt boot.
> It cycles lost interupt when detecting drives, it doesnt time out (each lost
> intrupt times out but it keeps looking continally).

Is that related to this patch, or is it a different issue?  I run
2.6.3 kernels compiled for SX164, Miata, and Avanti with no problems.

-- 
Måns Rullgård
mru@kth.se
