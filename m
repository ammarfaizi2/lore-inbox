Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWEWRmt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWEWRmt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 13:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbWEWRmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 13:42:49 -0400
Received: from smtpq3.tilbu1.nb.home.nl ([213.51.146.202]:20649 "EHLO
	smtpq3.tilbu1.nb.home.nl") by vger.kernel.org with ESMTP
	id S932093AbWEWRms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 13:42:48 -0400
Message-ID: <447349A6.50105@fastmail.fm>
Date: Tue, 23 May 2006 19:43:02 +0200
From: Simon Oosthoek <wmc_simon@fastmail.fm>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
CC: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] FLAME: external kernel module for L2.5 meshing
References: <44731733.7000204@ti-wmc.nl> <20060523094324.11926fcc@localhost.localdomain>
In-Reply-To: <20060523094324.11926fcc@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:
> On Tue, 23 May 2006 16:07:47 +0200
> Herman Elfrink <herman.elfrink@ti-wmc.nl> wrote:
> 
>>  
>> FLAME stands for "Forwarding Layer for Meshing"
>>
> 
> Didn't you just reinvent 802.1d bridging? and/or WDS?

I wouldn't say "reinvent", but the difference is small but significant. 
FLAME could be seen as ad hoc WDS, I think. It doesn't need to know 
about the other "base-stations", which I think WDS does.

> As far as the Ethernet protocol field. Getting a real assigned number
> would have to come out of the IEEE 802. 
> 
> You would need
> 	http://standards.ieee.org/regauth/ethertype/forms/index.html
> 
> It is cheaper (free vs $2500) to get a LLC sap assigned, but then
> you would have to change the protocol.
> 	http://standards.ieee.org/regauth/llc/index.html

Wow, thanks, $2500 is a bit steep for a useful experiment ;-)
The free option could be interesting though...

Cheers

Simon

