Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265679AbSKAKWx>; Fri, 1 Nov 2002 05:22:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265682AbSKAKWx>; Fri, 1 Nov 2002 05:22:53 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:29199 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S265679AbSKAKWw>; Fri, 1 Nov 2002 05:22:52 -0500
Message-ID: <3DC2578E.999E569C@aitel.hist.no>
Date: Fri, 01 Nov 2002 11:29:34 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.44 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.45 ipmr.c compile failure
References: <Pine.LNX.4.44.0210301651120.6719-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


net/ipv4/ipmr.c: In function `ipmr_forward_finish':
net/ipv4/ipmr.c:1114: structure has no member named `pmtu'
net/ipv4/ipmr.c: In function `ipmr_queue_xmit':
net/ipv4/ipmr.c:1170: structure has no member named `pmtu'

Helge Hafting
