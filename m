Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316289AbSHXN4u>; Sat, 24 Aug 2002 09:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316309AbSHXN4u>; Sat, 24 Aug 2002 09:56:50 -0400
Received: from dsl-213-023-021-235.arcor-ip.net ([213.23.21.235]:34729 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316289AbSHXN4t>;
	Sat, 24 Aug 2002 09:56:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: conman@kolivas.net, linux-kernel@vger.kernel.org
Subject: Re: VM changes added to performance patches for 2.4.19
Date: Sat, 24 Aug 2002 16:03:21 +0200
X-Mailer: KMail [version 1.3.2]
References: <1030170794.3d6728aa24046@kolivas.net>
In-Reply-To: <1030170794.3d6728aa24046@kolivas.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ibVa-0001Xf-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 August 2002 08:33, conman@kolivas.net wrote:
> With the patch against 2.4.19:
> 
> Scheduler O(1), Preemptible, Low Latency
> 
> I have now added two extra alternative patches that include 
> either Rik's rmap (thanks Rik) or AA's vm changes (thanks to Nuno Monteiro for
> merging this)
> 
> For the record, with the (very) brief usage of these two patches I found the
> rmap patch a little faster. This is very subjective and completely untested.

Would you be so kind as to attempt to quantify that?

-- 
Daniel
