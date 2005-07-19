Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVGSTdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVGSTdc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 15:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261481AbVGSTdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 15:33:32 -0400
Received: from opersys.com ([64.40.108.71]:5387 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261534AbVGSTdb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 15:33:31 -0400
Message-ID: <42DD5416.6030608@opersys.com>
Date: Tue, 19 Jul 2005 15:27:18 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Weird USB errors on HD
References: <42DD2EA4.5040507@opersys.com> <20050719192918.GA19803@kroah.com>
In-Reply-To: <20050719192918.GA19803@kroah.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg KH wrote:
> Ugh, you have a bad device or power supply, or aren't giving it enough
> power to drive the thing.  Nothing we can do in Linux for that, sorry.
> Buy a wall-powered usb hub, that usually helps.

I have one. I naively thought I could just plug the drive directly to the
laptop without using the wall-powered hub. I'll try that instead. Thanks.

That being said, shouldn't there be a way for the kernel to refuse to
use this hd if it's not getting enough power. I don't know enough about
USB to say, but isn't there something more elegant that could be done in
software?

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
