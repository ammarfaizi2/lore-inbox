Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261576AbVGZCWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261576AbVGZCWo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 22:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVGZCWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 22:22:43 -0400
Received: from opersys.com ([64.40.108.71]:26130 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S261576AbVGZCWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 22:22:43 -0400
Message-ID: <42E59CF7.9000405@opersys.com>
Date: Mon, 25 Jul 2005 22:16:23 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Weird USB errors on HD
References: <42DD2EA4.5040507@opersys.com> <200507201553.09602.s0348365@sms.ed.ac.uk>
In-Reply-To: <200507201553.09602.s0348365@sms.ed.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alistair John Strachan wrote:
> You can get special USB cables that link two USB ports' 5Vs together in 
> parallel, which seems to help supply the necessary current; after the HD has 
> spun up you can remove the second "dummy" USB connector (my laptop only has 
> two USB ports and I require the second port).

Yeah, there was one of these in the box with the drive, but the first time
I saw it I remember thinking: what the hell is this thing? Then when I
figured it out, I found myself wondering whether the USB interface was
ever planed for such a such and whether it wouldn't have been better to
just ship a real adapter with the thing ...

Anyhow, I will not be using the drive anymore without a powered hub.

Thanks for all those that helped,

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
