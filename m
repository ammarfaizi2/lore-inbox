Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280883AbRKBXhf>; Fri, 2 Nov 2001 18:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280882AbRKBXhZ>; Fri, 2 Nov 2001 18:37:25 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:33033 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S280884AbRKBXhO>; Fri, 2 Nov 2001 18:37:14 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Zlatko's I/O slowdown status
Date: Fri, 2 Nov 2001 23:37:13 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9rvan9$cn6$2@ncc1701.cistron.net>
In-Reply-To: <Pine.LNX.4.33.0110261018270.1001-100000@penguin.transmeta.com> <20011102065255.B3903@athlon.random> <87g07xdj6x.fsf@atlas.iskon.hr> <20011102152349.B17362@netnation.com>
X-Trace: ncc1701.cistron.net 1004744233 13030 195.64.65.67 (2 Nov 2001 23:37:13 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011102152349.B17362@netnation.com>,
Simon Kirby  <sim@netnation.com> wrote:
>If they have hdparm -W 0 at shutdown, there should be a -W 1 during
>startup.

Well no. It should be set back to 'power on default' on startup.
But there is no way to do that.

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

