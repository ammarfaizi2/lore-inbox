Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbVKVDXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbVKVDXZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 22:23:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbVKVDXZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 22:23:25 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:29075 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750741AbVKVDXY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 22:23:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pqowwwxvYel2hEHN2eaCXuUtaRKzon/hDumyF9RDvPbs8uCUW0b+Z+5QU9rC6ZhxS/b9UJubJH+4EMd6MyvCS4v6iffLfZhQbpumkiFp3ZDR1alVGwtCHR+DiW90znwWPmCNX7+sTkRL3Wex5wficW9NFZiEf501NyOml3F4vdU=
Message-ID: <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>
Date: Mon, 21 Nov 2005 22:23:21 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] Small PCI core patch
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1132626478.26560.104.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051121225303.GA19212@kroah.com>
	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>
	 <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>
	 <1132623268.20233.14.camel@localhost.localdomain>
	 <1132626478.26560.104.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/05, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> which is obviously impossible) etc... They really doesn't give a shit
> about what we think, and will continue to do so until they get a bit fat
> lawsuit, that is my opinion at least.

In the US you can't sue to force their hardware open until they are a
proven monopoly. And as long as we have both Nvidia and ATI splitting
the market we won't get a monopoly.

So the choices are:

1) Live in 1998. What happens in five years R200's are no longer
available, fallback to VGA?

2) Temporarily accept the ugly drivers. Let desktop development
continue. Work hard on getting the vendors to see the light and go
open source.

3) Use Linux on the server and run Mac or Windows on your desktop.

The choice's aren't exclusive, you can do all three if you want. The
catch is the part about advancing the Linux desktop, that can't happen
without access to current and new video hardware.

--
Jon Smirl
jonsmirl@gmail.com
