Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261471AbVCHU3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbVCHU3t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 15:29:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262271AbVCHU2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 15:28:45 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:12254 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261471AbVCHUOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 15:14:01 -0500
Subject: Re: Atheros wi-fi card drivers (?)
From: Lee Revell <rlrevell@joe-job.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Mateusz Berezecki <mateuszb@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1110216394.3072.72.camel@localhost.localdomain>
References: <422C7722.40301@gmail.com>
	 <1110216394.3072.72.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 08 Mar 2005 15:13:59 -0500
Message-Id: <1110312840.4600.4.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-07 at 17:26 +0000, Alan Cox wrote:
> On Llu, 2005-03-07 at 15:45, Mateusz Berezecki wrote:
> > I've been doing some reverse engineering of madwifi HAL (Hardware 
> > Abstraction Layer) object file recently.
> > I ended up with an almost complete source code for one chipset so far 
> > and I was wondering if it is legal
> > to publish such source code on the internet?
> 
> You should normally avoid doing this. Instead write a description of the
> chip registers and functions from the source you have produced and get
> someone else to write a chip driver from that. This avoids the risk of
> you being held to have "copied" their code - in the EU while you have
> rights to reverse engineer for interoperability in general if you copy
> their code that may still be a copyright violation.
> 

Just to clarify, this also applies to the USA.

> There is other code in the kernel where reverse engineering was used. 
> 

Heh, that is putting it mildly.  Linux driver support would be nowhere
without reverse engineering.

Lee

