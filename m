Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262032AbVFGXVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262032AbVFGXVE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 19:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbVFGXVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 19:21:04 -0400
Received: from relay.nsnoc.com ([195.69.95.145]:50590 "EHLO vs145.ukvs.net")
	by vger.kernel.org with ESMTP id S262032AbVFGXU4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 19:20:56 -0400
Message-ID: <42A62BD0.7090709@a-wing.co.uk>
Date: Wed, 08 Jun 2005 00:20:48 +0100
From: Andrew Hutchings <info@a-wing.co.uk>
Reply-To: info@a-wing.co.uk
Organization: A-Wing Internet Services
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: sis5513.c patch
References: <42A621BC.7040607@a-wing.co.uk> <20050607225755.GB30023@electric-eye.fr.zoreil.com>
In-Reply-To: <20050607225755.GB30023@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Andrew Hutchings <info@a-wing.co.uk> :
> [...]
> 
>>I'm looking at trying to revive the old sis190.c net driver for this 
>>board too, this does depend on my boss giving me some development time.
> 
> 
> If you don't mind scary crashes, you can take a look at:
> http://www.fr.zoreil.com/people/francois/misc/sis190-000.patch
> 
> I have not been able to find a K8S-MX at the local retailers. It does
> not help testing nor does it suggest that there is a strong need.
> 

Unfortunately I have been lumbered with 5 of these (insert rude word 
here) boards and have had problems with pretty much every driver.  SATA 
had to be download from SiS's website, PATA is as my patch (no idea why 
a sis5513 driver wasn't coded to detect a sis5513).  I used rev1.1 of 
the sis190.c driver along with a guy from India, he says it works, I say 
it doesn't (but it may be because my test network is 10Meg Half-Duplex). 
  Thank the heavens I am using this as a headless server, sound and 
video are a nightmare as well apparently.

Many thanks for the link, boss is going on holiday next week so as long 
as none of the servers melt down then I should be able to work on this.

Regards
Andrew

-- 
Andrew Hutchings (A-Wing)
Linux Guru - Netserve Consultants Ltd. - http://www.domaincity.co.uk/
Admin - North Wales Linux User Group - http://www.nwlug.org.uk/
BOFH excuse 357: I'd love to help you -- it's just that the Boss won't 
let me near the computer.
