Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUCWXgu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 18:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262915AbUCWXgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 18:36:50 -0500
Received: from mail.tpgi.com.au ([203.12.160.100]:65201 "EHLO
	mail5.tpgi.com.au") by vger.kernel.org with ESMTP id S262913AbUCWXgn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 18:36:43 -0500
Subject: Re: [Swsusp-devel] Re: swsusp problems [was Re: Your opinion on
	the merge?]
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Reply-To: ncunningham@users.sourceforge.net
To: Pavel Machek <pavel@suse.cz>
Cc: Michael Frank <mhf@linuxmail.org>, Jonathan Sambrook <swsusp@hmmn.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Swsusp mailing list <swsusp-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20040323231715.GH364@elf.ucw.cz>
References: <1079661410.15557.38.camel@calvin.wpcb.org.au>
	 <20040318200513.287ebcf0.akpm@osdl.org>
	 <1079664318.15559.41.camel@calvin.wpcb.org.au>
	 <20040321220050.GA14433@elf.ucw.cz>
	 <1079988938.2779.18.camel@calvin.wpcb.org.au>
	 <20040322231737.GA9125@elf.ucw.cz> <20040323095318.GB20026@hmmn.org>
	 <20040323214734.GD364@elf.ucw.cz>
	 <1080076132.12965.18.camel@calvin.wpcb.org.au>
	 <opr5b7tyt24evsfm@smtp.pacific.net.th>  <20040323231715.GH364@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1080081396.22641.9.camel@calvin.wpcb.org.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-2.norlug 
Date: Wed, 24 Mar 2004 10:36:36 +1200
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-03-24 at 11:17, Pavel Machek wrote:
> > > I'm also of a mind to not include the original
> > >text-mode 'nice display' and just use the Bootsplash support.
> > 
> > Which I would not agree with as this is what I use ;)

I could always make the ui a plugin too - along the lines of what
Michael is suggesting. That would be really simple: separate out the
bootsplash code and the text mode code into new files, perhaps in a ui
directory and adjust the Makefile & config.in accordingly.

Nigel
-- 
Nigel Cunningham
C/- Westminster Presbyterian Church Belconnen
61 Templeton Street, Cook, ACT 2614.
+61 (2) 6251 7727(wk); +61 (2) 6253 0250 (home)

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

