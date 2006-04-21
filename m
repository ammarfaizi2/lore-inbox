Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWDUNbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWDUNbY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 09:31:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbWDUNbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 09:31:24 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:30101 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932299AbWDUNbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 09:31:22 -0400
Date: Fri, 21 Apr 2006 15:30:26 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Greg KH <greg@kroah.com>
cc: Arjan van de Ven <arjan@infradead.org>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation
 of LSM hooks)
In-Reply-To: <20060419201154.GB20545@kroah.com>
Message-ID: <Pine.LNX.4.61.0604211528140.22097@yvahk01.tjqt.qr>
References: <200604142301.10188.edwin@gurde.com>
 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
 <20060417162345.GA9609@infradead.org> <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
 <20060417173319.GA11506@infradead.org> <Pine.LNX.4.64.0604171454070.17563@d.namei>
 <20060417195146.GA8875@kroah.com> <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
 <1145462454.3085.62.camel@laptopd505.fenrus.org> <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>
 <20060419201154.GB20545@kroah.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> Well then, have a look at http://alphagate.hopto.org/multiadm/
>> >
>> >hmm on first sight that seems to be basically an extension to the
>> >existing capability() code... rather than a 'real' LSM module. Am I
>> >missing something here?
>> 
>> (So what's the definition for a "real" LSM module?)
>
>No idea, try submitting the patch :)
>
Because it's too big, you only get URLs:

[01/02] http://alphagate.hopto.org/multiadm/mtadm_hooks-2.6.17-rc2.diff  137KB
[02/02] http://alphagate.hopto.org/multiadm/mtadm_module-2.6.17-rc2.diff  27KB

Don't mention CodingStyle, I know. This is just a post to respond to the
topic on why noone submitted it earlier.
I already see it coming...


Jan Engelhardt
-- 
