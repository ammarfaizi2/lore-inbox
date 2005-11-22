Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030216AbVKVWya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030216AbVKVWya (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 17:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbVKVWya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 17:54:30 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:7651 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030216AbVKVWya (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 17:54:30 -0500
Subject: Re: [RFC] Small PCI core patch
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <438389EF.6080405@didntduck.org>
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	 <9e4733910511220854m2c5ffbe0t67a53f6bae89653@mail.gmail.com>
	 <1132690676.20233.72.camel@localhost.localdomain>
	 <438389EF.6080405@didntduck.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 22 Nov 2005 23:26:49 +0000
Message-Id: <1132702009.20233.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-11-22 at 16:13 -0500, Brian Gerst wrote:
> What he means is the process of begging the vendors for specs for just 
> the 2D hardware engine won't work when a seperate 2D engine doesn't 
> exist anymore.

Which may be an opportunity or a threat. Nvidia for example long ago
provided enough info to do basic stuff with the TNT2 and RIVA cards. 

Even if its the same engine its not the same question.

