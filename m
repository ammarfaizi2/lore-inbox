Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWBKRGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWBKRGQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 12:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932341AbWBKRGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 12:06:16 -0500
Received: from smtpout10-04.prod.mesa1.secureserver.net ([64.202.165.238]:53988
	"HELO smtpout10-04.prod.mesa1.secureserver.net") by vger.kernel.org
	with SMTP id S932342AbWBKRGP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 12:06:15 -0500
Message-ID: <43EE1982.1050201@hackmiester.com>
Date: Sat, 11 Feb 2006 11:06:10 -0600
From: "hackmiester (Hunter Fuller)" <hackmiester@hackmiester.com>
Reply-To: hackmiester@hackmiester.com
Organization: hackmiester.com, Ltd.
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.12) Gecko/20050915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler? (Was Re: [Suspend2-devel]
 Re: [ 00/10] [Suspend2] Modules support.)
References: <20060201113710.6320.68289.stgit@localhost.localdomain> <20060209233406.GD3389@elf.ucw.cz> <200602101008.32368.nigel@suspend2.net> <200602101337.22078.rjw@sisk.pl> <20060210233507.GC1952@elf.ucw.cz> <70FB74EB-5503-432D-8749-FD5A6807C23C@mac.com>
In-Reply-To: <70FB74EB-5503-432D-8749-FD5A6807C23C@mac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:

> On Feb 10, 2006, at 18:35, Pavel Machek wrote:
> 
>> Anyway, it means that suspend is still quite a hot topic, and that  is 
>> good. (Linus said that suspend-to-disk is basically for people  that 
>> can't get suspend-to-RAM to work, and after I got suspend-to- RAM to 
>> work reliably here, I can see his point).
> 
> 
> I completely agree.  My Mac PowerBook has had suspend-to-RAM for a  long 
> time; I shut the lid and about 3 seconds later it's asleep, open  it and 
> 3 seconds later it's awake.  Leave it sleeping for a week on a  full 
> charge, come back to find it still asleep.  I can even put it to  sleep, 
> remove a drained battery and put in a fresh one (it has a  small 
> internal 2-minute RAM battery), then wake it up and resume  work.  I'm 
> curious though, what proportion of laptop hardware  actually has support 
> for suspend-to-RAM?  (including hardware for  which linux does not yet 
> have support).  

I'd say about... 100% of all in use today :-) Really, I've not seen a 
machine without APM or ACPI in ages...

> What percent of that  hardware _does_ have Linux support?

85% I'd say. My notebook supports suspend, but not stand by, in Linux. 
Suspend uses more battery. :-(

> 
> Cheers,
> Kyle Moffett
> 
> -- 
> If you don't believe that a case based on [nothing] could potentially  
> drag on in court for _years_, then you have no business playing with  
> the legal system at all.
>   -- Rob Landley
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 


-- 
--hackmiester
Walk a mile in my shoes and you will be a mile away in a new pair of shoes.
