Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282273AbRKWTu4>; Fri, 23 Nov 2001 14:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282262AbRKWTus>; Fri, 23 Nov 2001 14:50:48 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:51077 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S282273AbRKWTuR>;
	Fri, 23 Nov 2001 14:50:17 -0500
Message-ID: <3BFEA873.46325BEB@pobox.com>
Date: Fri, 23 Nov 2001 11:50:11 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.15-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: lgb@lgb.hu
CC: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Which gcc version?
In-Reply-To: <20011123125137Z282133-17408+17815@vger.kernel.org> <5.1.0.14.2.20011123135801.00aad970@pop.cus.cam.ac.uk> <3BFE591B.D1F75CD5@starband.net> <3BFE67E8.CFA0D371@redhat.com> <20011123163019.A5418@vega.digitel2002.hu>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is all silly FUD - time for the pointer again -

http://www.bero.org/gcc296.html

cu

jjs

Gábor Lénárt wrote:

> True, but as it's known, gcc-2.96 is NOT an official gcc release by the gcc
> team. It was RedHat's fault to fetch a development CVS gcc snapshot and
> release it as gcc 2.96 in RedHat distributions, while object format used by
> 2.96 is not compatible with 2.95 nor 3.0.x at least according information
> can be found on site of gcc. It was very ROTFL RedHat to release kgcc to be
> able to compile kernel. And these type of distributions are marked as even
> enterprise-ready and likes by RedHat :) Sorry for the flame, but IMHO it's
> very funny :) [Also, while developing MPlayer we had got problems with even
> newer 2.96's, so we do not recommend it in the dox, and ./configure won't
> able you to use 2.96 without a special configure switch ...]
>

