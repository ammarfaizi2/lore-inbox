Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964827AbWGHNTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964827AbWGHNTO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964828AbWGHNTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:19:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47745 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964827AbWGHNTN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:19:13 -0400
Subject: Re: [Suspend2-devel] Re: uswsusp history lesson
From: Arjan van de Ven <arjan@infradead.org>
To: Bojan Smojver <bojan@rexursive.com>
Cc: Jan Rychter <jan@rychter.com>, Pavel Machek <pavel@ucw.cz>,
       Avuton Olrich <avuton@gmail.com>, linux-kernel@vger.kernel.org,
       Olivier Galibert <galibert@pobox.com>,
       suspend2-devel@lists.suspend2.net, grundig <grundig@teleline.es>,
       Nigel Cunningham <ncunningham@linuxmail.org>
In-Reply-To: <1152357077.2088.4.camel@beast.rexursive.com>
References: <20060627133321.GB3019@elf.ucw.cz>
	 <20060707215656.GA30353@dspnet.fr.eu.org>
	 <20060707232523.GC1746@elf.ucw.cz>
	 <200607080933.12372.ncunningham@linuxmail.org>
	 <20060708002826.GD1700@elf.ucw.cz>  <m2d5cg1mwy.fsf@tnuctip.rychter.com>
	 <1152353698.2555.11.camel@coyote.rexursive.com>
	 <1152355318.3120.26.camel@laptopd505.fenrus.org>
	 <1152357077.2088.4.camel@beast.rexursive.com>
Content-Type: text/plain
Date: Sat, 08 Jul 2006 15:19:03 +0200
Message-Id: <1152364743.3120.42.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-08 at 21:11 +1000, Bojan Smojver wrote:
> On Sat, 2006-07-08 at 12:41 +0200, Arjan van de Ven wrote:
> 
> > What is worse, these suspend systems will inevitable have
> > different requirements on the rest of the kernel, and will thus
> > complicate the heck out of it for the rest of the developers.
> 
> My (user level) understanding is that built in swsusp and Suspend2 use
> the same (or almost the same) machinery in the rest of the kernel to do
> the work.

so they're almost the same conceptually... That's even more reason to go
for one unified approach.


