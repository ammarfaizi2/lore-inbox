Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751336AbWAaSk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbWAaSk7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 13:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751338AbWAaSk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 13:40:59 -0500
Received: from twin.uoregon.edu ([128.223.214.27]:26069 "EHLO twin.uoregon.edu")
	by vger.kernel.org with ESMTP id S1751336AbWAaSk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 13:40:58 -0500
Date: Tue, 31 Jan 2006 10:40:27 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: joelja@twin.uoregon.edu
To: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
cc: Sander <sander@humilis.net>, linux-kernel@vger.kernel.org,
       jgarzik@pobox.com
Subject: Re: [OT] 8-port AHCI SATA Controller?
In-Reply-To: <20060131183013.GH18970@csclub.uwaterloo.ca>
Message-ID: <Pine.LNX.4.64.0601311033330.24453@twin.uoregon.edu>
References: <20060131115343.GA2580@favonius> <20060131163928.GE18972@csclub.uwaterloo.ca>
 <20060131171723.GA6178@favonius> <20060131183013.GH18970@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2006, Lennart Sorensen wrote:

> On Tue, Jan 31, 2006 at 06:17:23PM +0100, Sander wrote:
>> According to page 7 of the
>> "Serial ATA Advanced Host Controller Interface Revision 1.1"
>> (available at http://www.intel.com/technology/serialata/ahci.htm), AHCI
>> supports up to 32 ports.
>
> Hmm, that's a nice feature set.  Here is hoping everyone will consider
> switching to that, and that no one screws it up and makes a mostly but
> not quite compliant version.
>
>> For example, Silicon Image 3124 also looks good on paper, but only
>> supports up to 4 ports.
>>
>> Yeah, I know, but because of their real 'hardware' raid, these cards are
>> three times more expensive per port. And I just need JBOD.
>
> Really?  How much does a 24 port areca card cost?  Is it 12 times the
> cost of a two port promise card?

about $1400 for pci-x or $1900 pci-express.

you might try the promise sataII-150 sx8 which is 8 ports per card and is 
about $200

> I haven't looked at the prices lately.

The jump to a full-on sata raid controller is pretty steep.

> Len Sorensen
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
--------------------------------------------------------------------------
Joel Jaeggli  	       Unix Consulting 	       joelja@darkwing.uoregon.edu
GPG Key Fingerprint:     5C6E 0104 BAF0 40B0 5BD3 C38B F000 35AB B67F 56B2

