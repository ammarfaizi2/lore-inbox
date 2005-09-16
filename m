Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161059AbVIPGqs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161059AbVIPGqs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 02:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161061AbVIPGqs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 02:46:48 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:26306 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S1161059AbVIPGqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 02:46:48 -0400
From: "Peter T. Breuer" <ptb@inv.it.uc3m.es>
Message-Id: <200509160646.j8G6kFg00923@inv.it.uc3m.es>
Subject: Re: .o.cmd files wanted, static analysis
In-Reply-To: <0CF04ACB-C931-4016-B50C-233FEA7AC78C@mac.com> from "Kyle Moffett"
 at "Sep 15, 2005 08:08:40 pm"
To: "Kyle Moffett" <mrmacman_g4@mac.com>
Date: Fri, 16 Sep 2005 08:46:15 +0200 (MET DST)
CC: "linux kernel" <linux-kernel@vger.kernel.org>
X-Anonymously-To: 
Reply-To: ptb@inv.it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Also sprach Kyle Moffett:"
> On Sep 15, 2005, at 19:50:29, Peter T. Breuer wrote:
> > Does somebody out there have a pretty complete kernel compilation,  
> > mainly all modules (though I don't care!), and could let me have  
> > their .*.o.cmd files? In fact, just the FIRST LINE of them.
> 
> doesn't "make allmodconfig" work for you?  That should generate a  

Thanks. I didn't know about allconfig. That sounds good.. But no,
it wouldn't exactly work for me just like that - I don't have space
to do the actual kernel compilation on any machine (nor time to do it,
since the fastest machine is my laptop at 1.13GHz, and that suffers from
overheating problems - the next fastest machine is a dual 550MHz, and I
will start that churning but space is tight everywhere  and I am pretty
sure that there is no chance to get it to go to a finish as is).

> config with everything possible included as modules, and then you can  
> compile that to generate .cmd files.

Has anyone already done it? I was hoping there was somebody running a
big compile every day in order to check consistency. Then I could
simply "borrow" their files!

Failing that, I'll try setting CC to something like FOO, and seeing if
I can generate the .o.cmd files without the compilation actually being
done. Hmmm ...

Peter
