Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310134AbSB1VxS>; Thu, 28 Feb 2002 16:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310141AbSB1Vvj>; Thu, 28 Feb 2002 16:51:39 -0500
Received: from uucp.cistron.nl ([195.64.68.38]:27404 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S310121AbSB1VtQ>;
	Thu, 28 Feb 2002 16:49:16 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: serial console in single mode does not function
Date: Thu, 28 Feb 2002 21:49:15 +0000 (UTC)
Organization: Cistron
Message-ID: <a5m8kr$4jg$1@ncc1701.cistron.net>
In-Reply-To: <3C7E6A84.DED890F6@lmt.lv>
Content-Type: text/plain; charset=iso-8859-15
X-Trace: ncc1701.cistron.net 1014932955 4720 195.64.65.67 (28 Feb 2002 21:49:15 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3C7E6A84.DED890F6@lmt.lv>,
Andrejs Dubovskis  <adu@lmt.lv> wrote:
>When system with serial console is started in single mode it boots
>shell. But any button pressed in terminal does not go to console.
>Looks like hanged system. Nothing changed but kernel (2.4.14) only
>and serial console works as expected: any pressed chars are displayed
>in console.
>Kernels 2.4.17 and 2.4.18 was checked and do not function.

Update your sysvinit package.

Mike.
-- 
Computers are useless, they only give answers. --Pablo Picasso

