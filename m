Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423723AbWKFKO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423723AbWKFKO5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 05:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423724AbWKFKO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 05:14:57 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24220 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1423723AbWKFKO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 05:14:56 -0500
Subject: Re: [ANNOUNCE] kvm howto
From: Arjan van de Ven <arjan@infradead.org>
To: Avi Kivity <avi@argo.co.il>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <454EF7A8.10504@argo.co.il>
References: <4549F1D5.8070509@qumranet.com> <20061105171424.GA7045@irc.pl>
	 <454EF7A8.10504@argo.co.il>
Content-Type: text/plain
Organization: Intel International BV
Date: Mon, 06 Nov 2006 11:14:54 +0100
Message-Id: <1162808094.3160.190.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> See 
> http://forum.thinkpads.com/viewtopic.php?p=203419&sid=8f3fe5a07430fe35c6bf8c32e6058a87
> 
> 
> >  I wandered around BIOS setup (latest version), but didn't found
> > anything about virtualization. Is BIOS check really necessary?
> >   
> 
> Yes.  The thing is a brick as far as hardware virtualization is 
> concerned.  Complain to your vendor.

is there an easy way this can be checked for? If so I'd love to add this
as check to the linux-ready firmware developer kit (see URL in sig) as
something to test bioses for...

> 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

