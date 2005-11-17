Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbVKQRb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbVKQRb2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVKQRb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:31:28 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:43269 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932451AbVKQRb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:31:27 -0500
Date: Thu, 17 Nov 2005 18:31:17 +0100
From: Olivier Galibert <galibert@pobox.com>
To: kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051117173117.GC10402@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	kernel list <linux-kernel@vger.kernel.org>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116191051.GG2193@spitz.ucw.cz> <20051117165437.GA10402@dspnet.fr.eu.org> <20051117164451.GA27178@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051117164451.GA27178@kroah.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2005 at 08:44:51AM -0800, Greg KH wrote:
> Both.  -to-ram depends on your video chip,

i855GM with xorg-6.8.2 (-r6 gentoo) ?

i830CGC with xorg-6.8.2 (-r4 gentoo) ?


> but to-disk should work just fine.

Ok.

> If not, please report bugs.

I shall.

Is the acpi problem with PWRF used over PWRC and PWRF not sending
events (hence no wakeup) solved?

  OG.
