Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWDSVGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWDSVGA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 17:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbWDSVF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 17:05:59 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:15591 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751251AbWDSVF6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 17:05:58 -0400
Date: Wed, 19 Apr 2006 23:05:38 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Arjan van de Ven <arjan@infradead.org>
cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Greg KH <greg@kroah.com>,
       jmorris@namei.org, hch@infradead.org, akpm@osdl.org, sds@tycho.nsa.gov,
       edwin@gurde.com, linux-security-module@vger.kernel.org,
       linux-kernel@vger.kernel.org, chrisw@sous-sol.org, torvalds@osdl.org
Subject: Re: Time to remove LSM (was Re: [RESEND][RFC][PATCH 2/7] implementation
 of LSM hooks)
In-Reply-To: <1145480071.3085.103.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0604192305120.4411@yvahk01.tjqt.qr>
References: <200604142301.10188.edwin@gurde.com> 
 <1145290013.8542.141.camel@moss-spartans.epoch.ncsc.mil> 
 <20060417162345.GA9609@infradead.org>  <1145293404.8542.190.camel@moss-spartans.epoch.ncsc.mil>
  <20060417173319.GA11506@infradead.org>  <Pine.LNX.4.64.0604171454070.17563@d.namei>
  <20060417195146.GA8875@kroah.com>  <Pine.LNX.4.61.0604191010300.12755@yvahk01.tjqt.qr>
  <1145462454.3085.62.camel@laptopd505.fenrus.org> 
 <Pine.LNX.4.61.0604192102001.7177@yvahk01.tjqt.qr>  <20060419201154.GB20545@kroah.com>
  <20060419135207.dfc2d8ee.rdunlap@xenotime.net> <1145480071.3085.103.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>ok for me it would be "implements it's own security_ops vector" as
>criterium. 
>
multiadm does that. :>



Jan Engelhardt
-- 
