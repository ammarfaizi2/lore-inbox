Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129669AbRAQIhS>; Wed, 17 Jan 2001 03:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130036AbRAQIhI>; Wed, 17 Jan 2001 03:37:08 -0500
Received: from 24dyn201.com21.casema.net ([213.17.94.201]:25350 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S129669AbRAQIgz>;
	Wed, 17 Jan 2001 03:36:55 -0500
Date: Wed, 17 Jan 2001 09:35:59 +0100
From: bert hubert <ahu@ds9a.nl>
To: linux-kernel@vger.kernel.org
Subject: Re: eepro100 error messages
Message-ID: <20010117093558.B3707@home.ds9a.nl>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3A650B5B.EE1CCB07@corp124.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre4i
In-Reply-To: <3A650B5B.EE1CCB07@corp124.com>; from kostas@corp124.com on Tue, Jan 16, 2001 at 07:02:52PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 16, 2001 at 07:02:52PM -0800, Kostas Nikoloudakis wrote:

> The machine is running under heavy CPU + memory + network load.
> It seems that the card has problems finding the required resources.
> Is there a way to "guarantee" that the card will have the necessary
> resources even at high loads?
> 
> I'm using kernel version 2.2.14.

Try using 2.2.18 - lots of work has been done to get the eepro100 working
properly.

Regards,

bert hubert

-- 
PowerDNS                     Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
