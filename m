Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130241AbRAZI6H>; Fri, 26 Jan 2001 03:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132487AbRAZI55>; Fri, 26 Jan 2001 03:57:57 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:2834 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S130241AbRAZI5n>; Fri, 26 Jan 2001 03:57:43 -0500
Message-ID: <3A713BD6.6EABC3F3@idb.hist.no>
Date: Fri, 26 Jan 2001 09:56:54 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: no, da, en
MIME-Version: 1.0
To: mirabilos <eccesys@topmail.de>, linux-kernel@vger.kernel.org
Subject: Re: hotmail can't deal with ECN
In-Reply-To: <14960.29127.172573.22453@pizda.ninka.net> <200101251905.f0PJ5ZG216578@saturn.cs.uml.edu> <14960.31423.938042.486045@pizda.ninka.net> <20010125115214.D9992@draco.foogod.com> <01c201c0870b$5af92000$0100a8c0@homeip.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mirabilos wrote:

> Correct - and additionally: what's about Win 95-ME, NT, W2K; *BSD?
> When I'm end user they don't block an ECN connection I thought, or do they?
> Idea: some1 makes up a web server.
>  - If I can connect ECN is working
>  - On the site I can enter my mail addy and get a mail there. If it arrives, everything is ok.
> 

Don't worry.  NT, W2K, etc. have no problems with ECN.  They may not use
the ECN information, but they have no problem with packets using ECN.
The problem is some paranoid firewalls that drop ECN packets - no
matter what the os is on the machine you are trying to reach.

Helge Hafting
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
