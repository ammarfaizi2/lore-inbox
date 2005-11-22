Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965198AbVKVVML@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965198AbVKVVML (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 16:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965214AbVKVVLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 16:11:21 -0500
Received: from quark.didntduck.org ([69.55.226.66]:10414 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S965204AbVKVVLS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 16:11:18 -0500
Message-ID: <438389EF.6080405@didntduck.org>
Date: Tue, 22 Nov 2005 16:13:19 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mail/News 1.5 (X11/20051105)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
References: <20051121225303.GA19212@kroah.com>	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>	 <9e4733910511220854m2c5ffbe0t67a53f6bae89653@mail.gmail.com> <1132690676.20233.72.camel@localhost.localdomain>
In-Reply-To: <1132690676.20233.72.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Maw, 2005-11-22 at 11:54 -0500, Jon Smirl wrote:
>> Removal of the 2D engines is a key vulnerability in the strategy of
>> only using 2D on Linux.
> 
> I must have missed something, there isn't such a strategy anywhere I
> know either in X or in the kernel. EXA in X is designed to make using
> the 3D engine to do the 2D rendering much easier.

What he means is the process of begging the vendors for specs for just 
the 2D hardware engine won't work when a seperate 2D engine doesn't 
exist anymore.

--
				Brian Gerst
