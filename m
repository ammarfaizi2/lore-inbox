Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264144AbTLOWgp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 17:36:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264145AbTLOWgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 17:36:45 -0500
Received: from adsl-67-114-19-185.dsl.pltn13.pacbell.net ([67.114.19.185]:49027
	"EHLO bastard") by vger.kernel.org with ESMTP id S264144AbTLOWgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 17:36:43 -0500
Message-ID: <3FDE376D.4060309@tupshin.com>
Date: Mon, 15 Dec 2003 14:36:29 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
Cc: Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: RFC - tarball/patch server in BitKeeper
References: <20031214172156.GA16554@work.bitmover.com> <2259130000.1071469863@[10.10.2.4]> <20031215151126.3fe6e97a.vsu@altlinux.ru> <20031215132720.GX7308@phunnypharm.org> <20031215192402.528ce066.vsu@altlinux.ru> <20031215183138.GJ6730@dualathlon.random> <20031215185839.GA8130@work.bitmover.com> <20031215194057.GL6730@dualathlon.random> <20031215214452.GB8130@work.bitmover.com>
In-Reply-To: <20031215214452.GB8130@work.bitmover.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:

>The second you start
>extracting BK metadata for the benefit of some SCM development effort,
>that's a violation of the BKL.
>  
>
Right here, you conflate action and intent. I asked about whether 
somebody could legally make the changesets of a bitkeeper archive 
publicly available. Will you be issuing a cease and desist order to Rik 
van Riel for making changesets available at 
ftp://nl.linux.org/pub/linux/bk2patch/patches-v2.5/ ??? I have found 
this information to be very interesting. I haven't gone off and 
developed an nth generation SCM product, but I have gathered a lot of 
interesting quantifiable information about kernel development patterns, 
statistics, etc. Who's violating what license, exactly?

>It's your data and that data includes your checkin comments but that is
>all.  It's our tool and the use of our tool to export information how the
>data is managed is a violation of our license.
>
Can you point out the relevant portion of the BKL? According to the BKL, 
changesets fall into the category of "Metadata". The only restrictions 
placed on metadata is that they be transmitted to an open logging 
server. The only conceivable restriction I can find is the global 
non-compete clause contained in 3-d: "Notwithstanding any other terms in 
this License, this License is not available to You if You and/or your 
employer develop, produce, sell, and/or resell a product which contains 
substantially similar capabil- ities of the BitKeeper Software, or, in 
the reason- able opinion of BitMover, competes with the BitKeeper 
Software."
Does somebody like Rik magically fall under this clause because he makes 
changesets publicly available?

-Tupshin
