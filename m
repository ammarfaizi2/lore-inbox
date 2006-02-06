Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbWBFSCu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbWBFSCu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 13:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWBFSCu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 13:02:50 -0500
Received: from mail.gmx.net ([213.165.64.21]:45787 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932102AbWBFSCu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 13:02:50 -0500
X-Authenticated: #428038
Message-ID: <43E78F46.2000900@gmx.de>
Date: Mon, 06 Feb 2006 19:02:46 +0100
From: Matthias Andree <matthias.andree@gmx.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: jengelh@linux01.gwdg.de, mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       bzolnier@gmail.com, acahalan@gmail.com
Subject: Re: CD writing in future Linux try #2 [ was: Re: CD writing in future
 Linux (stirring up a hornets' nest) ]
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com> <43DCA097.nailGPD11GI11@burner> <Pine.LNX.4.61.0601291212360.18492@yvahk01.tjqt.qr> <43DE2FA8.nail16ZB1XOPF@burner> <Pine.LNX.4.61.0602051300430.11476@yvahk01.tjqt.qr> <43E7795D.nail81Y3TBMUC@burner>
In-Reply-To: <43E7795D.nail81Y3TBMUC@burner>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

[Solaris cdrecord command]
>>   cdrecord -dev=/dev/rdsk/c1t0d0p0 -toc

> Once I see to many people using this kind of CLI, I'll add a note.

Still fighting both your users and the environment, eh?

Why do you want to enforce device enumeration on your users if it isn't
needed in the first place?

Your motives remain totally unclear, and look rather suicidal.
