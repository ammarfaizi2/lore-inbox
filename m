Return-Path: <linux-kernel-owner+w=401wt.eu-S932847AbWLNQHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932847AbWLNQHI (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 11:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932846AbWLNQHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 11:07:08 -0500
Received: from zcars04f.nortel.com ([47.129.242.57]:58037 "EHLO
	zcars04f.nortel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932847AbWLNQHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 11:07:05 -0500
X-Greylist: delayed 1381 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 11:07:05 EST
Message-ID: <458170FF.9030801@nortel.com>
Date: Thu, 14 Dec 2006 09:42:55 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050427 Red Hat/1.7.7-1.1.3.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rik van Riel <riel@redhat.com>
CC: Greg KH <gregkh@suse.de>, Jonathan Corbet <corbet@lwn.net>,
       Andrew Morton <akpm@osdl.org>, Martin Bligh <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches
 for 2.6.19]
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net> <20061214005532.GA12790@suse.de> <20061214051015.GA3506@nostromo.devel.redhat.com> <20061214084820.GA29311@suse.de> <4581595C.7080508@redhat.com>
In-Reply-To: <4581595C.7080508@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Dec 2006 15:43:11.0406 (UTC) FILETIME=[8F5BC4E0:01C71F96]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:

> Why would users buy a piece of hardware that needs a binary
> only driver that's unsupportable, when they can buy a similar
> piece of hardware that has a driver that's upstream and is
> supported by every single Linux distribution out there?

In my experience it falls into a number of categories:

1) The system that requires the binary driver has other hardware on it 
that is required for the app.

2) The system that requires the binary driver costs significantly less, 
enough that they decide to bite the bullet on the software support side.

3) The system that requires the binary driver is the *only* one 
available in the specified form factor with the specified cpu architecture.

4) The team that decides on the hardware is totally divorced from the OS 
guys, so they don't know/care what is supported by open source drivers 
in the first place.

Chris
