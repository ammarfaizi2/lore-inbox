Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135610AbRAMABQ>; Fri, 12 Jan 2001 19:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135791AbRAMABG>; Fri, 12 Jan 2001 19:01:06 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55557 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135610AbRAMAA5>; Fri, 12 Jan 2001 19:00:57 -0500
Subject: Re: [BUG] 2.4.0-ac8 PS/2 mouse woes
To: zinx@magenet.com (Forever shall I be.)
Date: Sat, 13 Jan 2001 00:02:35 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010112173811.A618@bliss.zebra.net> from "Forever shall I be." at Jan 12, 2001 05:38:11 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14HE9V-0005ID-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> pc_keyb.c..   I also have the cuecat patch applied, and use it over
> the PS/2 mouse port, but I don't think it's interfering..  I doubt
> this will be noticable to people not using the "Resolution" option to
> speed up the mouse, and mine's rather insane:

Can you tell me if the problem can be duplicated without the cuecat patch
applied. It is quite possible the ps/2 mouse patch is buggy

> Anyway, just letting you know, and very sorry for the lack of
> information..

Its most of the info I need. Since I churn through patches fast we can normally
get a good guess at the culprit.

Alan


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
