Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261699AbSJZWww>; Sat, 26 Oct 2002 18:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261717AbSJZWww>; Sat, 26 Oct 2002 18:52:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:64006 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261699AbSJZWww>;
	Sat, 26 Oct 2002 18:52:52 -0400
Message-ID: <3DBB1E29.5020402@pobox.com>
Date: Sat, 26 Oct 2002 18:58:49 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "H. J. Lu" <hjl@lucon.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: Support PCI device sorting (Re: PCI device order problem)
References: <1035540031.13032.3.camel@irongate.swansea.linux.org.uk> <20021025091102.A15082@lucon.org> <20021025202600.A3293@lucon.org> <3DBB0553.5070805@pobox.com> <20021026142704.A13207@lucon.org> <3DBB0A81.6060909@pobox.com> <20021026144441.A13479@lucon.org> <3DBB1150.2030800@pobox.com> <20021026152043.A13850@lucon.org> <3DBB1743.6060309@pobox.com> <20021026155342.A14378@lucon.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. J. Lu wrote:

>>The basic point is "let's proceed with caution, and test test test 
>>before applying this patch."
>>    
>>
>
>Please state clearly what you have in mind. First you were
>saying you didn't like pci_sort_by_bus_slot_func defined when
>CONFIG_PCI_SORT_BY_BUS_SLOT_FUNC wass not set. Now you were
>saying my patch was dangerous. Please make up your mind.
>  
>

In my first reply, I clearly separated implementation issues from 
commentary on the overall idea.  Aside from that, I don't see much value 
in further repeating what I've already said.

    Jeff




