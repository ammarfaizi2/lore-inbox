Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310953AbSCROVN>; Mon, 18 Mar 2002 09:21:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310960AbSCROVC>; Mon, 18 Mar 2002 09:21:02 -0500
Received: from boa.mtg-marinetechnik.de ([62.153.155.10]:56057 "EHLO
	anaconda.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id <S310953AbSCROUu>; Mon, 18 Mar 2002 09:20:50 -0500
Message-ID: <3C95F7BF.D9126D69@gmx.net>
Date: Mon, 18 Mar 2002 15:20:47 +0100
From: Richard Ems <r.ems.mtg@gmx.net>
Reply-To: r.ems@gmx.net
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-4GB i686)
X-Accept-Language: en, de, es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 freezes on heavy IO
In-Reply-To: <3C95F129.7D9744B5@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Which rpm?  k_i386, k_deflt, k_psmp, k_smp?  This is probably the
>(aa specific) ext3 deadlock recently fixed by andrea and andrew.
>
>-chris

k_deflt-2.4.18-30.i386.rpm

Andrea's fix should already be there! (as read in
http://ftp.gwdg.de/pub/linux/suse/ftp.suse.com/people/mantel/next/lx_sus24.changes)

Richard


-- 
   Richard Ems
   ... e-mail: r.ems@gmx.net
   ... Computer Science, University of Hamburg

   Unix IS user friendly. It's just selective about who its friends are.
