Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750817AbVHWUyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750817AbVHWUyK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 16:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbVHWUyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 16:54:09 -0400
Received: from [203.171.93.254] ([203.171.93.254]:63437 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S1750817AbVHWUyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 16:54:09 -0400
Subject: Re: [patch] suspend: update warnings
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Dave Jones <DaveJ@redhat.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050823150501.GA23171@redhat.com>
References: <20050822081528.GA4418@elf.ucw.cz>
	 <1124753566.5093.8.camel@localhost> <20050823125017.GB3664@elf.ucw.cz>
	 <1124801595.4602.18.camel@localhost>  <20050823150501.GA23171@redhat.com>
Content-Type: text/plain
Organization: Cyclades
Message-Id: <1124830428.4826.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 24 Aug 2005 06:53:49 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave.

On Wed, 2005-08-24 at 01:05, Dave Jones wrote:
> On Tue, Aug 23, 2005 at 10:53:16PM +1000, Nigel Cunningham wrote:
> 
>  > > > - CPU Freq  (improving too)
>  > > > It might be good to mention these areas too.
>  > > Well, right; but those 'only' cause system to crash during suspend. I
>  > > was talking about really dangerous stuff.
>  > > Both usb and cpufreq seems to work okay here.
>  > It depends on what you're using. I believe one of the usb root hub
>  > drivers is okay, the others aren't. Similar for cpufreq.
> 
> If you know a specific cpufreq driver which has problems, I'm all ears.

Here's the report from a user that I'm thinking of:

http://lists.suspend2.net/lurker/message/20050822.140001.6bf4abfe.en.html

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.

