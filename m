Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317202AbSFFVys>; Thu, 6 Jun 2002 17:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317201AbSFFVyq>; Thu, 6 Jun 2002 17:54:46 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:39322
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S317202AbSFFVyN>; Thu, 6 Jun 2002 17:54:13 -0400
Date: Thu, 6 Jun 2002 18:00:29 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Arjan Filius <iafilius@xs4all.nl>
Cc: "Brian J. Conway" <bconway@WPI.EDU>, linux-kernel@vger.kernel.org
Subject: Re: Promise Ultra100 hang
Message-ID: <20020606180029.A22061@animx.eu.org>
In-Reply-To: <Pine.OSF.4.43.0206061239390.14804-100000@cpu.WPI.EDU> <Pine.LNX.4.44.0206062043470.6451-100000@sjoerd.sjoerdnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Same issue here, 2.4.18 running fine with my new 160GB maxtor drive on a
> promise udma100 ide controller, 2.4.19-pre9 hangs on partition check at
> boot time.
> 
> I saw in the incremental patches many promise related changes in
> pre8->pre9, but i havn't tested pre8 yet.
> 
> 
> I've inlcluded my /var/log/boot.msg (2.4.18) in case this may help to
> solve the problem.

Try 2.4.19-pre10-ac2

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
