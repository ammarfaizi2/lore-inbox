Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285417AbRLGTCY>; Fri, 7 Dec 2001 14:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285450AbRLGTCG>; Fri, 7 Dec 2001 14:02:06 -0500
Received: from smtp2.home.se ([195.66.35.201]:25354 "EHLO smtp2.home.se")
	by vger.kernel.org with ESMTP id <S285417AbRLGTBE>;
	Fri, 7 Dec 2001 14:01:04 -0500
Message-ID: <3C1111D0.9B7E30FF@home.se>
Date: Fri, 07 Dec 2001 20:00:32 +0100
From: Daniel Bergman <d-b@home.se>
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Henning Schmiedehausen <hps@intermeta.de>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description
In-Reply-To: <20011207080603.B6983@work.bitmover.com> <2692295916.1007714643@[10.10.1.2]> <20011207092314.F27589@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> My pay job is developing a distributed source management system which works
> by replication.  We already have users who put all the etc files in it and
> manage them that way.  Works great.  It's like rdist except it never screws
> up and it has merging.

I'm just curious, what about security? Is this done in clear-text? 
Sounds dangerous to put /etc/shadow, for example, in clear-text on the
cable.

Sorry for getting off-topic.

Regards,
Daniel

--
Daniel Bergman
Phone: 08 - 55064278
Mobile: 08 - 6311430 
Fax: 08 - 59827056
Email: d-b@home.se
