Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265090AbTFCQk2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265092AbTFCQk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:40:28 -0400
Received: from mailgate.rz.uni-karlsruhe.de ([129.13.64.97]:16657 "EHLO
	mailgate.rz.uni-karlsruhe.de") by vger.kernel.org with ESMTP
	id S265090AbTFCQk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:40:26 -0400
Date: Tue, 3 Jun 2003 18:53:15 +0200
From: Matthias Mueller <matthias.mueller@rz.uni-karlsruhe.de>
To: Michael Frank <mflt1@micrologica.com.hk>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, Marc Wilson <msw@cox.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc6
Message-ID: <20030603165315.GC1975@rz.uni-karlsruhe.de>
Mail-Followup-To: Michael Frank <mflt1@micrologica.com.hk>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	Marc Wilson <msw@cox.net>, lkml <linux-kernel@vger.kernel.org>
References: <20030529052425.GA1566@moonkingdom.net> <20030529055735.GB1566@moonkingdom.net> <Pine.LNX.4.55L.0306031302310.3892@freak.distro.conectiva> <200306040030.27640.mflt1@micrologica.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306040030.27640.mflt1@micrologica.com.hk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 12:30:27AM +0800, Michael Frank wrote:
> On Wednesday 04 June 2003 00:02, Marcelo Tosatti wrote:
> -rc6 is better - comparable to 2.4.18 in what I have seen with my script.  
> 
> After the long obscure problems since 2.4.19x, -rc6 could use serious 
> stress-testing. 
> 
> User level testing is not sufficient here - it's just like playing roulette.
> 
> By serious stress-testing I mean:
> 
> Everone testing comes up with  one dedicated "tough test" 
> which _must_ be reproducible (program, script) along his line of 
> expertise/application.
> 
> Two or more of these independent tests are run in combination.

Agreed and I'm willing to run test-scripts on my system, that has these
hangs (long ones with 2.4.19-pre1 to 2.4.21-rc5 and only short ones with
2.4.21-rc6). But at the moment I have neither time nor enough knowledge to
write a test to reproduce it.

So if someone comes up with a suitable test skript, I'm happy to try it
and use it on different kernel versions.

Bye,
Matthias
-- 
Matthias.Mueller@rz.uni-karlsruhe.de
Rechenzentrum Universitaet Karlsruhe
Abteilung Netze
