Return-Path: <linux-kernel-owner+w=401wt.eu-S1750939AbWLSM5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbWLSM5v (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 07:57:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750937AbWLSM5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 07:57:51 -0500
Received: from bld-mail07.adl2.internode.on.net ([203.16.214.71]:37985 "EHLO
	mail.internode.on.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750836AbWLSM5v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 07:57:51 -0500
From: Marek Wawrzyczny <marekw1977@yahoo.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Date: Tue, 19 Dec 2006 23:57:45 +1100
User-Agent: KMail/1.9.5
References: <MDEHLPKNGKAHNMBLJOLKCEAPAGAC.davids@webmaster.com> <Pine.LNX.4.62.0612171109180.27120@pademelon.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0612171109180.27120@pademelon.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612192357.45443.marekw1977@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 December 2006 21:11, Geert Uytterhoeven wrote:
> Since `works with' may sound a bit too vague, something like
> `LinuxFriendly(tm)', with a happy penguin logo?

It would be really cool to see penguin logos on hardware :)

I had another, probably crazy idea. Would it be possible to utilize the 
current vendor/device PCI ID database to create Linux friendliness matrix 
site?

And if you let yourself get carried away, you can also imagine a little 
multi-platform utility. It would run on a test system collecting PCI IDs 
before submitting them to the site  to get the system's overall Linux 
friendliness rating.

In cases where the system contains devices which do not have entries in the 
database, the system could look up and use the vendor's Linux friendliness 
rating.

Something like that could really help end users to select the right system and 
would reward those who do the right thing.


Cheers,

Marek Wawrzyczny
