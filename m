Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbWEHIgF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbWEHIgF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 04:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbWEHIgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 04:36:05 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:28567 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932364AbWEHIgC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 04:36:02 -0400
Message-ID: <445F02E4.5000004@sgi.com>
Date: Mon, 08 May 2006 10:35:48 +0200
From: Jes Sorensen <jes@sgi.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Grant Coady <gcoady.lk@gmail.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Brent Casavant <bcasavan@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ide@vger.kernel.org, akpm@osdl.org, jeremy@sgi.com
Subject: Re: [PATCH] Move various PCI IDs to header file
References: <20060504180614.X88573@chenjesu.americas.sgi.com>	 <20060504173722.028c2b24.rdunlap@xenotime.net> <445AE690.5030700@sgi.com>	 <Pine.LNX.4.58.0605050926250.3161@shark.he.net>	 <0jkn52lnu505eb26plf5o7buertimg2e6v@4ax.com>  <445EF968.3080903@sgi.com> <1147077120.2888.5.camel@laptopd505.fenrus.org>
In-Reply-To: <1147077120.2888.5.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2006-05-08 at 09:55 +0200, Jes Sorensen wrote:
>> So much for being able to go through the pci_ids.h file to get an idea
>> about whether or not a device may have a chance of being supported :(
> 
> that wasn't there ever anyway..
> 
> modules.pcimap is more like it anyway

Wasn't bullet proof since some people just stuck it in their drivers due
to laziness, but it was a pretty good indicator. I've gone through it
many times to see if I could find a match for a device ;(

Anyway ....

Cheers,
Jes
