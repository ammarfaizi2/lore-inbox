Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292375AbSBUNZr>; Thu, 21 Feb 2002 08:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292373AbSBUNZZ>; Thu, 21 Feb 2002 08:25:25 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:30212 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292292AbSBUNZU>; Thu, 21 Feb 2002 08:25:20 -0500
Subject: Re: VM problems still in 2.4.17?
To: jonathan@jonmasters.org (Jon Masters)
Date: Thu, 21 Feb 2002 13:39:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10202211143050.661-100000@router> from "Jon Masters" at Feb 21, 2002 11:44:27 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dtRJ-0006vv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can someone tell me what the state of play is concerning VM issues in
> 2.4.17? I've had another spontaneous panic overnight that I'm hoping to
> debug later but the last few times this has happened has been due to vm.

Try 2.4.18rc2. If its the LRU and related funnies then 2.4.18rc2 should
be a lot more solid. The 2.4.18-rc2 vm behaves somewhat better than 2.4.17
in normal situations too
