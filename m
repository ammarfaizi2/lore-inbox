Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbVKVPqq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbVKVPqq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 10:46:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbVKVPqq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 10:46:46 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:55824 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S964944AbVKVPqp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 10:46:45 -0500
Message-ID: <43833D61.9050400@argo.co.il>
Date: Tue, 22 Nov 2005 17:46:41 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
References: <20051121225303.GA19212@kroah.com>	 <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston>	 <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>	 <1132623268.20233.14.camel@localhost.localdomain>	 <1132626478.26560.104.camel@gaston> <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>
In-Reply-To: <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2005 15:46:43.0724 (UTC) FILETIME=[F00BACC0:01C5EF7B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:

>1) Live in 1998. What happens in five years R200's are no longer
>available, fallback to VGA?
>
>2) Temporarily accept the ugly drivers. Let desktop development
>continue. Work hard on getting the vendors to see the light and go
>open source.
>
>3) Use Linux on the server and run Mac or Windows on your desktop.
>
>  
>
4) Write a translation layer (for xorg or the kernel) that can load 
Windows drivers. Use binary translation for non-x86. Hope the APIs are 
not patented.
