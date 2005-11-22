Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbVKVWAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbVKVWAg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 17:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030192AbVKVWAZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 17:00:25 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:30984 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1030190AbVKVWAI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 17:00:08 -0500
Message-ID: <438394E1.8080505@argo.co.il>
Date: Wed, 23 Nov 2005 00:00:01 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Diego Calleja <diegocg@gmail.com>
CC: jgarzik@pobox.com, jonsmirl@gmail.com, benh@kernel.crashing.org,
       alan@lxorguk.ukuu.org.uk, airlied@gmail.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
References: <20051121225303.GA19212@kroah.com>	<20051121230136.GB19212@kroah.com>	<1132616132.26560.62.camel@gaston>	<21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com>	<1132623268.20233.14.camel@localhost.localdomain>	<1132626478.26560.104.camel@gaston>	<9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com>	<43833D61.9050400@argo.co.il>	<20051122155143.GA30880@havoc.gtf.org>	<43834400.3040506@argo.co.il>	<20051122172650.72f454de.diegocg@gmail.com>	<438348BB.1050504@argo.co.il>	<20051122204910.a4bd1d1e.diegocg@gmail.com>	<43837AD1.7060504@argo.co.il> <20051122214327.37b902e4.diegocg@gmail.com>
In-Reply-To: <20051122214327.37b902e4.diegocg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 22 Nov 2005 22:00:05.0973 (UTC) FILETIME=[18D39850:01C5EFB0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Diego Calleja wrote:

>El Tue, 22 Nov 2005 22:08:49 +0200,
>Avi Kivity <avi@argo.co.il> escribió:
>
>  
>
>>None of the desktop Windows installations I'm aware of exhibit this. The 
>>recent versions of Windows are fairly stable.
>>    
>>
>
>You don't seem to check frecuently windows help forums, where some people
>speaks of nvidia as the number 1 "bluescreener"...
>
>Lots of windows drivers _are_ crappy. It's just a fact - some companies
>hire the wrong people. Some companies (like nvidia) get money from being
>fast, not from stability. This is a good example from a microsoft
>programmer about how some companies cheat the WHQL certification to
>get faster drivers...
>http://blogs.msdn.com/oldnewthing/archive/2004/03/05/84469.aspx
>
>This one about silent install of drivers by "smart" installers is fun
>too: http://blogs.msdn.com/oldnewthing/archive/2005/08/16/452141.aspx
>
>  
>
Awsome. Certainly a very strong point against Windows drivers.

>  
>
>>Many people have hyperthreaded CPUs today.
>>    
>>
>
>Hypertreaded CPUs can't run the two virtual cpus at the same time,
>  
>
Actually they are parallel at the instruction level. For the purpose of 
SMP-safety they are the same as true SMP. They just have different 
performance characterestics.

>>It works well on the server, where Linux has a large and rising market 
>>    
>>
>
>Linux didn't always have a large market share on servers. Again, history
>has shown that the path taken by linux until now is succesful.
>  
>
I hope you're right. But desktops are more complex, more varied, and 
have much more, er, interesting, users.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

