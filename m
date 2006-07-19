Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWGSMDX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWGSMDX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 08:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWGSMDX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 08:03:23 -0400
Received: from mail.metronet.co.uk ([213.162.97.75]:62177 "EHLO
	mail.metronet.co.uk") by vger.kernel.org with ESMTP id S964798AbWGSMDX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 08:03:23 -0400
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Bernd Petrovitsch <bernd@firmix.at>
Subject: Re: [PATCH] Support DOS line endings
Date: Wed, 19 Jul 2006 13:02:43 +0100
User-Agent: KMail/1.9.3
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20060707173458.GB1605@parisc-linux.org> <20060713210725.GA1923@mars.ravnborg.org> <1152826904.3084.1.camel@gimli.at.home>
In-Reply-To: <1152826904.3084.1.camel@gimli.at.home>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607191302.43452.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 July 2006 22:41, Bernd Petrovitsch wrote:
> On Thu, 2006-07-13 at 23:07 +0200, Sam Ravnborg wrote:
> [...]
>
> > Thanks. Maybe I should just stop trying to code anything today ;-)
>
> Or take it as a sign to not support DOS line endings.

It certainly would be better to warn if a file with DOS line endings is being 
used, even if supported, so that such files never enter the kernel 
undetected.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
