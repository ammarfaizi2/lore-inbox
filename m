Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266952AbTGTLjf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 07:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266966AbTGTLjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 07:39:35 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10624 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266952AbTGTLje
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 07:39:34 -0400
Date: Sun, 20 Jul 2003 12:54:32 +0100
From: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: AMD Athlon MP Machine check exceptions
Message-ID: <20030720115432.GB628@gallifrey>
References: <20030719225935.GA628@gallifrey> <20030720082041.GD643@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030720082041.GD643@alpha.home.local>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/2.6.0-test1 (i686)
X-Uptime: 12:44:59 up 12:55,  1 user,  load average: 0.27, 0.35, 0.40
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Willy Tarreau (willy@w.ods.org) wrote:
> Hi !
> 
> You should feed it through Dave Jones' parsemce program.

Thank you! Unfortunatly Dave's site seems to be down at the moment
(and google don't seem to have it cached - why?)

> BTW, he already
> replied a few months ago to exactly the same report (search 940040000000017a
> on google, you have it already decoded :-))

Ah - I hadn't thought of searching for the hex, I'd presumed that
related to a particular bank/address/cache line and the chances of lots
of people hitting the same one would be slim - unless there is a
problem? Perhaps when I get parsemce it will be clearer.

Dave
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    | Running GNU/Linux on Alpha,68K| Happy  \ 
\ gro.gilbert @ treblig.org | MIPS,x86,ARM,SPARC,PPC & HPPA | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
