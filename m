Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284820AbRLURPk>; Fri, 21 Dec 2001 12:15:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284831AbRLURPa>; Fri, 21 Dec 2001 12:15:30 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:25875 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S284820AbRLURPS>; Fri, 21 Dec 2001 12:15:18 -0500
Subject: Re: aio
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Fri, 21 Dec 2001 17:24:33 +0000 (GMT)
Cc: davem@redhat.com (David S. Miller), billh@tierra.ucsd.edu,
        torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org
In-Reply-To: <20011219224717.A3682@redhat.com> from "Benjamin LaHaise" at Dec 19, 2001 10:47:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16HTPN-0000v0-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Who cares about Java?  What about high performance LDAP servers or tux-like 
> userspace performance?  How about faster select and poll?  An X server that 

select/poll is a win - and Java recently discovered poll/select semantics 8)
