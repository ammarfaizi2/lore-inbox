Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262852AbULRH7K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbULRH7K (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 02:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbULRH7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 02:59:10 -0500
Received: from wasp.net.au ([203.190.192.17]:20417 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S262852AbULRH7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 02:59:06 -0500
Message-ID: <41C3E34D.4090203@wasp.net.au>
Date: Sat, 18 Dec 2004 11:59:09 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Mozilla Thunderbird 1.0RC1 (X11/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: manu@kromtek.com
CC: David Lawyer <dave@lafn.org>, Pavel Machek <pavel@suse.cz>,
       Park Lee <parklee_sel@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Issue on connect 2 modems with a single phone line
References: <20041215184206.43601.qmail@web51505.mail.yahoo.com> <20041216085828.GG1189@lafn.org> <41C3D5AD.7090507@wasp.net.au> <200412181145.59211.manu@kromtek.com>
In-Reply-To: <200412181145.59211.manu@kromtek.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manu Abraham wrote:
> On Sat December 18 2004 11:01 am, Brad Campbell wrote:

>>I have used analogue modems back to back for years and have *never* come
>>across a modem that sourced anything other than it's ringing signal (via an
>>opto) from the phone line. Every single modem I have here will talk to the
>>others over a straight telephone cable.
> 
> What about power ? The opto-coupler will not work without power.
> 

If you read what I wrote you will note the opto-coupler is used for ring detection only and then 
only triggers when it sees an AC ring pulse. You don't need ring detection to run modems back to 
back and therefore it's not a problem.

As for the Capacitor and Transformer, you are correct. I merely mis-communicated my message.
Point is the same, you can connect 90% of Analogue modems back to back with only a bit of wire and 
they will talk. (I say 90% as I'm sure there is one out there somewhere that uses the phone line 
voltage for something but I have *never* seen one). Remember that off-hook phone voltages can get 
down to around 3v while on hook you may have 50v.

Don't theorize about it, try it.

-- 
Brad
                    /"\
Save the Forests   \ /     ASCII RIBBON CAMPAIGN
Burn a Greenie.     X      AGAINST HTML MAIL
                    / \
