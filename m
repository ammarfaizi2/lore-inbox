Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282913AbRLDJER>; Tue, 4 Dec 2001 04:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282922AbRLDJEL>; Tue, 4 Dec 2001 04:04:11 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28944 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S282961AbRLDJEB>; Tue, 4 Dec 2001 04:04:01 -0500
Subject: Re: Linux/Pro [was Re: Coding style - a non-issue]
To: Martin.Bligh@us.ibm.com
Date: Tue, 4 Dec 2001 09:12:35 +0000 (GMT)
Cc: ebiederm@xmission.com (Eric W. Biederman),
        linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <2379810054.1007402157@mbligh.des.sequent.com> from "Martin J. Bligh" at Dec 03, 2001 05:55:57 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BBcx-0001Kh-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > can come up with a single system image solution over fast ethernet a
> > ccNuma machine just magically works.
> 
> it's not cc if you just use fast ethernet.

Thats a matter for handwaving and distributed shared memory algorithms. The
general point is still true - if you assume your NUMA interconnects are
utter crap when performance and latency issues come up - you'll get the
right results.
