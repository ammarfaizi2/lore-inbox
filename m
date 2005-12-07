Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVLGQyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVLGQyL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 11:54:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVLGQyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 11:54:11 -0500
Received: from covilha.procergs.com.br ([200.198.128.244]:58320 "EHLO
	covilha.procergs.com.br") by vger.kernel.org with ESMTP
	id S1751178AbVLGQyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 11:54:10 -0500
From: Otavio Salvador <otavio@debian.org>
To: Greg KH <gregkh@suse.de>
Cc: Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       ehabkost@mandriva.com
Subject: Re: [PATCH 00/10] usb-serial: Switches from spin lock to atomic_t.
Organization: O.S. Systems Ltda.
References: <20051206095610.29def5e7.lcapitulino@mandriva.com.br>
	<20051207164118.GA28032@suse.de>
X-URL: http://www.debian.org/~otavio/
X-Attribution: O.S.
Date: Wed, 07 Dec 2005 14:55:07 -0200
In-Reply-To: <20051207164118.GA28032@suse.de> (Greg KH's message of "Wed, 7
	Dec 2005 08:41:18 -0800")
Message-ID: <87vey0hmok.fsf@nurf.casa>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> writes:

> That's the right thing to do, so I'm not going to take this patch series
> right now because of that.  If you all want to work on moving to use the
> serial core, I would love to see that happen.

But wouldn't be better to have this intermediary solution merged while
someone work on this conversion?

-- 
        O T A V I O    S A L V A D O R
---------------------------------------------
 E-mail: otavio@debian.org      UIN: 5906116
 GNU/Linux User: 239058     GPG ID: 49A5F855
 Home Page: http://www.freedom.ind.br/otavio
---------------------------------------------
"Microsoft gives you Windows ... Linux gives
 you the whole house."
