Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131747AbQKZXOR>; Sun, 26 Nov 2000 18:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131530AbQKZXN5>; Sun, 26 Nov 2000 18:13:57 -0500
Received: from [194.213.32.137] ([194.213.32.137]:18948 "EHLO bug.ucw.cz")
        by vger.kernel.org with ESMTP id <S130783AbQKZXNr>;
        Sun, 26 Nov 2000 18:13:47 -0500
Date: Fri, 24 Nov 2000 08:09:50 +0000
From: Pavel Machek <pavel@suse.cz>
To: Guest section DW <dwguest@win.tue.nl>
Cc: Keith Owens <kaos@ocs.com.au>, "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: silly [< >]
Message-ID: <20001124080950.C214@toy>
In-Reply-To: <200011251026.eAPAQKG210983@saturn.cs.uml.edu> <6551.975150464@ocs3.ocs-net> <20001125192030.A7152@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20001125192030.A7152@win.tue.nl>; from dwguest@win.tue.nl on Sat, Nov 25, 2000 at 07:20:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You complain that most important information is on begging of OOps. So what
about moving most important info to the end? I.e. stack trace first, EIP next;
or even print EIP twice. Than s to [<, ksymoops will not break ;-)
								Pavel

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
