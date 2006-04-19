Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751223AbWDSUtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751223AbWDSUtn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 16:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWDSUtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 16:49:43 -0400
Received: from xenotime.net ([66.160.160.81]:33465 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751223AbWDSUtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 16:49:41 -0400
Date: Wed, 19 Apr 2006 13:52:07 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Greg KH <greg@kroah.com>
Cc: jengelh@linux01.gwdg.de, arjan@infradead.org, jmorris@namei.org,
       hch@infradead.org, akpm@osdl.org, sds@tycho.nsa.gov, edwin@gurde.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       chrisw@sous-sol.org, torvalds@osdl.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
 implementation of LSM hooks)
Message-Id: <20060419135207.dfc2d8ee.rdunlap@xenotime.net>
In-Reply-To: <20060419201154.GB20545@kroah.com>
References: <200604142301.10188.edwin@gurde.com>
	<1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	<20060417162345.GA9609@infradead.org>
	<1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
	<20060417173319.GA11506@infradead.org>
	<Pine.LNX.4.64.0604171454070.17563@d.namei>
	<20060417195146.GA8875@kroah.com>
	<Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
	<1145462454.3085.62.camel@laptopd505.fenrus.org>
	<Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>
	<20060419201154.GB20545@kroah.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Apr 2006 13:11:54 -0700 Greg KH wrote:

> On Wed, Apr 19, 2006 at 09:06:57PM +0200, Jan Engelhardt wrote:
> > >> 
> > >> Well then, have a look at http://alphagate.hopto.org/multiadm/
> > >> 
> > >
> > >hmm on first sight that seems to be basically an extension to the
> > >existing capability() code... rather than a 'real' LSM module. Am I
> > >missing something here?
> > >
> > 
> > (So what's the definition for a "real" LSM module?)
> 
> No idea, try submitting the patch :)

hrm, I guess the smiley is supposed to help??

surely someone knows that it takes to qualify as a "real"
LSM module.  I would have expected Greg to be in that group
of people.

---
~Randy
