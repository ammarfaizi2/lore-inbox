Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261476AbSJ1T4y>; Mon, 28 Oct 2002 14:56:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261477AbSJ1T4y>; Mon, 28 Oct 2002 14:56:54 -0500
Received: from modemcable063.18-202-24.mtl.mc.videotron.ca ([24.202.18.63]:65297
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261476AbSJ1T4y>; Mon, 28 Oct 2002 14:56:54 -0500
Date: Mon, 28 Oct 2002 14:57:18 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Alan Cox <alan@redhat.com>,
       Dave Jones <davej@codemonkey.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Double x86 initialise fix.
In-Reply-To: <1035647180.13244.121.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0210281452200.1722-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Oct 2002, Alan Cox wrote:

> > Eh? I don't understand this, and I think Dave is right for all the
> > IBM monsters I know of ;-) The *apicid* may not be 0 but the CPU
> > numbers are dynamically assigned as we boot, so the boot CPU will
> > always get 0, surely?
> 
> Ok its a logical ID - so yes

<pedantic> kernel logical ID ;)  </pedantic>

-- 
function.linuxpower.ca


