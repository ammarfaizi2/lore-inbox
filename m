Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266186AbTBCIl2>; Mon, 3 Feb 2003 03:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266210AbTBCIl2>; Mon, 3 Feb 2003 03:41:28 -0500
Received: from news.cistron.nl ([62.216.30.38]:59404 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S266186AbTBCIl1>;
	Mon, 3 Feb 2003 03:41:27 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Compactflash cards dying?
Date: Mon, 3 Feb 2003 08:50:58 +0000 (UTC)
Organization: Cistron Group
Message-ID: <b1lahi$qvq$1@ncc1701.cistron.net>
References: <20030202223009.GA344@elf.ucw.cz> <1044232591.545.8.camel@sonja>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1044262258 27642 62.216.29.200 (3 Feb 2003 08:50:58 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1044232591.545.8.camel@sonja>,
Daniel Egger  <degger@fhm.edu> wrote:
>CF has limited write cycles. A few hundred if you're lucky.
>And depending on the type of flash it's quite likely that every
>changed byte will result in a whole block being written back.

Then why if I google for 'compact flash write cycles' all specs
of flash cards I found say 100000 write cycles at least ?

Mike.
-- 
Anyone who is capable of getting themselves made President should
on no account be allowed to do the job -- Douglas Adams.

