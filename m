Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279711AbRKAUTi>; Thu, 1 Nov 2001 15:19:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279717AbRKAUTZ>; Thu, 1 Nov 2001 15:19:25 -0500
Received: from news.cistron.nl ([195.64.68.38]:7953 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S279700AbRKAUS1>;
	Thu, 1 Nov 2001 15:18:27 -0500
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: Linux 2.2 and 2.4 VM systems analysed
Date: Thu, 1 Nov 2001 20:18:26 +0000 (UTC)
Organization: Cistron Internet Services B.V.
Message-ID: <9rsami$iq1$3@ncc1701.cistron.net>
In-Reply-To: <3BE1A790.25B7E6F5@illusionary.com>
X-Trace: ncc1701.cistron.net 1004645906 19265 195.64.65.67 (1 Nov 2001 20:18:26 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test75 (Feb 13, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BE1A790.25B7E6F5@illusionary.com>,
Derek Glidden  <dglidden@illusionary.com> wrote:
>For overall end-user experience, 2.2 still "feels" better overall with
>better interactive responsiveness under a varying set of loads even
>though 2.4 really is faster at doing the actual work.

Well today I switched my workstation (128 MB RAM, 256 MB swap)
over from 2.2.19 to 2.4.14-pre6. With mozilla, netscape, postgres,
perl, apache, X, gnome running I'm usually ~80 MB into swap.
With 2.2.19 you really don't want to do this. It's *slow*.
Early 2.4.x, ditto. But under 2.4.14-pre6, it flies. I'm happy.

Mike.
-- 
"Only two things are infinite, the universe and human stupidity,
 and I'm not sure about the former" -- Albert Einstein.

