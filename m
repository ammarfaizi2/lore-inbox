Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131121AbRADRxI>; Thu, 4 Jan 2001 12:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131125AbRADRw6>; Thu, 4 Jan 2001 12:52:58 -0500
Received: from passion.cambridge.redhat.com ([172.16.18.67]:34688 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S131121AbRADRwu>; Thu, 4 Jan 2001 12:52:50 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.31.0101040942550.10387-100000@dlang.diginsite.com> 
In-Reply-To: <Pine.LNX.4.31.0101040942550.10387-100000@dlang.diginsite.com> 
To: David Lang <david.lang@digitalinsight.com>
Cc: Daniel Phillips <phillips@innominate.de>,
        Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: Journaling: Surviving or allowing unclean shutdown? 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 04 Jan 2001 17:52:25 +0000
Message-ID: <10290.978630745@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


david.lang@digitalinsight.com said:
> for crying out loud, even windows tells the users they need to
> shutdown first and gripes at them if they pull the plug. what users
> are you trying to protect, ones to clueless to even run windows?

Precisely. Users of embedded devices don't expect to have to treat them
like computers.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
