Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263869AbTDZARm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 20:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263993AbTDZARl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 20:17:41 -0400
Received: from dci.doncaster.on.ca ([66.11.168.194]:32451 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S263869AbTDZARl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 20:17:41 -0400
Message-ID: <3EA9D36D.5030104@suwalski.net>
Date: Fri, 25 Apr 2003 20:31:41 -0400
From: Pat Suwalski <pat@suwalski.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Werner Almesberger <wa@almesberger.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Jamie Lokier <jamie@shareable.org>,
       Matthias Schniedermeyer <ms@citd.de>, Marc Giger <gigerstyle@gmx.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 623] New: Volume not remembered.
References: <20030423231149.I3557@almesberger.net> <25450000.1051152052@[10.10.2.4]> <20030424003742.J3557@almesberger.net> <20030424071439.GB28253@mail.jlokier.co.uk> <20030424103858.M3557@almesberger.net> <20030424213632.GK30082@mail.jlokier.co.uk> <20030424205515.T3557@almesberger.net> <3EA87BE1.1070107@suwalski.net> <20030425074116.V3557@almesberger.net> <1051265094.5573.8.camel@dhcp22.swansea.linux.org.uk> <20030425144449.X3557@almesberger.net> <427040000.1051293569@[10.10.2.4]>
In-Reply-To: <427040000.1051293569@[10.10.2.4]>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh wrote:
> BTW, I realised there's a much simpler solution to the "but there's no
> sound coming out" problem .... xmms and friends should just give the user a
> warning on startup (or on play) if the main volume or pcm channel is at 0
> (or muted).

No. This never happens.

It only complains if it its OSS output plugin cannot communicate with 
the kernel.

At least on all the cards I have ever used.

--Pat

