Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282627AbRKZWdO>; Mon, 26 Nov 2001 17:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282621AbRKZWdH>; Mon, 26 Nov 2001 17:33:07 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:44806 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S282626AbRKZWc5>; Mon, 26 Nov 2001 17:32:57 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Default outgoing IP address?
Date: Mon, 26 Nov 2001 22:32:56 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9tufuo$ahr$3@ncc1701.cistron.net>
In-Reply-To: <Pine.LNX.4.40.0111261612390.15983-100000@waste.org>
X-Trace: ncc1701.cistron.net 1006813976 10811 195.64.65.67 (26 Nov 2001 22:32:56 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.40.0111261612390.15983-100000@waste.org>,
Oliver Xymoron  <oxymoron@waste.org> wrote:
>On a machine with multiple interfaces, is it possible to set the default
>outgoing IP address to something other than the address for the interface
>on the outgoing route?

ip route add default via IP.OF.GATE.WAY dev DEVICE src SOURCE.IP.ADDR.ESS

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

