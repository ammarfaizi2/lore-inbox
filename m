Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750960AbWDSQBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750960AbWDSQBj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWDSQBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:01:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34015 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750772AbWDSQBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:01:38 -0400
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7]
	implementation of LSM hooks)
From: Arjan van de Ven <arjan@infradead.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Greg KH <greg@kroah.com>, James Morris <jmorris@namei.org>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, T?r?k Edwin <edwin@gurde.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       Chris Wright <chrisw@sous-sol.org>, Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
References: <200604021240.21290.edwin@gurde.com>
	 <200604072138.35201.edwin@gurde.com>
	 <1144863768.32059.67.camel@moss-spartans.epoch.ncsc.mil>
	 <200604142301.10188.edwin@gurde.com>
	 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417162345.GA9609@infradead.org>
	 <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
	 <20060417173319.GA11506@infradead.org>
	 <Pine.LNX.4.64.0604171454070.17563@d.namei>
	 <20060417195146.GA8875@kroah.com>
	 <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Wed, 19 Apr 2006 18:00:54 +0200
Message-Id: <1145462454.3085.62.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-04-19 at 10:16 +0200, Jan Engelhardt wrote:
> 
> Well then, have a look at http://alphagate.hopto.org/multiadm/
> 

hmm on first sight that seems to be basically an extension to the
existing capability() code... rather than a 'real' LSM module. Am I
missing something here?

