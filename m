Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261819AbSIZBHH>; Wed, 25 Sep 2002 21:07:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261852AbSIZBHG>; Wed, 25 Sep 2002 21:07:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:22716 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261819AbSIZBHG>; Wed, 25 Sep 2002 21:07:06 -0400
Message-ID: <3D926046.4C098C3A@us.ibm.com>
Date: Wed, 25 Sep 2002 18:17:58 -0700
From: Nivedita Singhvi <niv@us.ibm.com>
X-Mailer: Mozilla 4.78 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
References: <3D924F9D.C2DCF56A@us.ibm.com.suse.lists.linux.kernel> <20020925.170336.77023245.davem@redhat.com.suse.lists.linux.kernel> <p73n0q5sib2.fsf@oldwotan.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> I guess he's thinking of the FIB, not the routing cache.

I was, + chain explansion, but this is just (um, cough)
to s/he/she

:)
thanks,
Nivedita

> The current FIBs have a bit heavier locking at least. Fine grain locking
> btrees is also not easy/nice.
> 
> -Andi
