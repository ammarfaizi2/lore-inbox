Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317184AbSFRAN7>; Mon, 17 Jun 2002 20:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317185AbSFRAN6>; Mon, 17 Jun 2002 20:13:58 -0400
Received: from nwkea-mail-1.sun.com ([192.18.42.13]:12027 "EHLO
	nwkea-mail-1.sun.com") by vger.kernel.org with ESMTP
	id <S317184AbSFRAN6>; Mon, 17 Jun 2002 20:13:58 -0400
Date: Mon, 17 Jun 2002 17:06:27 -0700 (PDT)
From: Seth Goldberg <Seth.Goldberg@Sun.COM>
To: linux-kernel@vger.kernel.org
cc: Seth Goldberg <Seth.Goldberg@Sun.COM>
Subject: genksyms not doing its job?
Message-ID: <Pine.GSO.4.44.0206171700170.197503-100000@limud.sfbay.sun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

  I was wondering if anyone was also experiencing a problem in generating
kernel symbols for the 2.5.22 kernel.  I am notificing quite a few ksyms
that have not been properly generated (e.g. "sprintf_R__ver_sprintf"
instead of "sprintf_Rsmp_xxxxxxxx").  Please pardon me if this is a FAQ,
but I have installed the lated modutils and am still experiencing this
problem.

 Thanks,
  Seth


