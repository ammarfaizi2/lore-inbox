Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262773AbVAFIa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262773AbVAFIa3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 03:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVAFIa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 03:30:29 -0500
Received: from math.ut.ee ([193.40.5.125]:64405 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S262773AbVAFIa0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 03:30:26 -0500
Date: Thu, 6 Jan 2005 10:30:18 +0200 (EET)
From: Meelis Roos <mroos@linux.ee>
To: Dmitry Torokhov <dtor_core@ameritech.net>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ville Hallik <ville@linux.ee>
Subject: Re: 2.6.9+ keyboard LED problem
In-Reply-To: <200501060143.13428.dtor_core@ameritech.net>
Message-ID: <Pine.SOC.4.61.0501061028130.25618@math.ut.ee>
References: <20050106001203.DAD7E14C47@ondatra.tartu-labor>
 <200501060143.13428.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could you please try the patch below? It is just a quick hack, just to prove
> the idea. If it works for you I will prepare the proper fix later.

Seems to cure it, cannot find any problems in 100+ keypresses.

-- 
Meelis Roos
