Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292886AbSCISzj>; Sat, 9 Mar 2002 13:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292895AbSCISz3>; Sat, 9 Mar 2002 13:55:29 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:33033 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292893AbSCISzV>; Sat, 9 Mar 2002 13:55:21 -0500
Subject: Re: BUG REPORT: kernel nfs between 2.4.19-pre2 (server) and 2.2.21-pre3 (client)
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Sat, 9 Mar 2002 19:10:52 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20020309131956.77ebf679.skraw@ithnet.com> from "Stephan von Krawczynski" at Mar 09, 2002 01:19:56 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16jmF2-0002GF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I just upgraded a host from 2.2.19 to 2.2.21-pre3 and discovered a problem with kernel nfs. Setup is this:
> 
> knfs-server is 2.4.19-pre2
> knfs-client is 2.2.21-pre3

Do you see this with 2.2.20 (2.2.20 has NFS changes in the client, 2.2.21pre
does not) ?
