Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbVL1MsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVL1MsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 07:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964803AbVL1MsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 07:48:08 -0500
Received: from 213-140-2-70.ip.fastwebnet.it ([213.140.2.70]:47592 "EHLO
	aa003msg.fastwebnet.it") by vger.kernel.org with ESMTP
	id S964802AbVL1MsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 07:48:07 -0500
Date: Wed, 28 Dec 2005 13:44:41 +0100
From: Paolo Ornati <ornati@fastwebnet.it>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Steven Rostedt <rostedt@goodmis.org>, michael@metaparadigm.com,
       pwil3058@bigpond.net.au, rlrevell@joe-job.com, s0348365@sms.ed.ac.uk,
       jaco@kroon.co.za, linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: recommended mail clients [was] [PATCH] ati-agp suspend/resume
 support (try 2)
Message-ID: <20051228134441.233ba81b@localhost>
In-Reply-To: <20051227181433.3d5e7945.rdunlap@xenotime.net>
References: <43AF7724.8090302@kroon.co.za>
	<200512261535.09307.s0348365@sms.ed.ac.uk>
	<1135619641.8293.50.camel@mindpipe>
	<200512262003.38552.s0348365@sms.ed.ac.uk>
	<1135630831.8293.89.camel@mindpipe>
	<43B1D6C6.30300@metaparadigm.com>
	<43B1E5C1.4050908@bigpond.net.au>
	<43B1F203.6010401@metaparadigm.com>
	<Pine.LNX.4.58.0512272107140.10936@gandalf.stny.rr.com>
	<20051227181433.3d5e7945.rdunlap@xenotime.net>
X-Mailer: Sylpheed-Claws 2.0.0-rc1 (GTK+ 2.6.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Dec 2005 18:14:33 -0800
"Randy.Dunlap" <rdunlap@xenotime.net> wrote:

> > Hmm, another reason I like evolution. It has an insert file, so all you
> > need to do is select "Preformat" and then select insert file, and it puts
> > the file into where the cursor is without any modifications.
> 
> sylpheed is always in 'preformat' mode then.  :)
> All I have to do is "Insert" and select the file.

This depends on the sylpheed version / options...

Sylpheed-claws v2.0 has many options for wrapping:

	Wrap on input
	Wrap before sending
	Wrap quotation
	Wrap pasted text

And everything can be ON/OFF.

The only bad thing is that the "Insert File" function is affected by
"Wrap on input" option... so the best way to insert patches is to PASTE
them OR disable every wrapping option and wrap paragraphs with
"Ctrl+L" :)

-- 
	Paolo Ornati
	Linux 2.6.15-rc7-plugsched on x86_64
