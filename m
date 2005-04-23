Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261707AbVDWSym@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261707AbVDWSym (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 14:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261715AbVDWSy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 14:54:28 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:5591 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261707AbVDWSwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 14:52:15 -0400
Date: Sat, 23 Apr 2005 20:44:38 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: Linus Torvalds <torvalds@osdl.org>, David Woodhouse <dwmw2@infradead.org>,
       Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Git-commits mailing list feed.
Message-ID: <20050423184438.GD7100@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Linus Torvalds <torvalds@osdl.org>,
	David Woodhouse <dwmw2@infradead.org>,
	Jan Dittmer <jdittmer@ppp0.net>, Greg KH <greg@kroah.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Git Mailing List <git@vger.kernel.org>
References: <42674724.90005@ppp0.net> <20050422002922.GB6829@kroah.com> <426A4669.7080500@ppp0.net> <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net> <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org> <20050423175422.GA7100@cip.informatik.uni-erlangen.de> <Pine.LNX.4.58.0504231125330.2344@ppc970.osdl.org> <20050423183909.GC7100@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423183909.GC7100@cip.informatik.uni-erlangen.de>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> # This creates only the signature in Ascii Armor.
> gpg -a --detach-sign < to_sign > signature

# And to verify:
gpg --verify signature to_sign

	Thomas
