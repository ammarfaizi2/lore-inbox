Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262415AbSKCVRT>; Sun, 3 Nov 2002 16:17:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262479AbSKCVRT>; Sun, 3 Nov 2002 16:17:19 -0500
Received: from imo-m07.mx.aol.com ([64.12.136.162]:56522 "EHLO
	imo-m07.mx.aol.com") by vger.kernel.org with ESMTP
	id <S262415AbSKCVRL>; Sun, 3 Nov 2002 16:17:11 -0500
Message-ID: <3DC593A8.2030204@netscape.net>
Date: Sun, 03 Nov 2002 16:22:48 -0500
From: Nicholas Wourms <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Flavio Stanchina <flavio.stanchina@tin.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: Petition against kernel configuration options madness...
References: <200211031809.45079.josh@stack.nl> <aq41b9$dt9$1@main.gmane.org> <3DB5E7CA00439C7E@smtp2.cp.tin.it> (added by postmaster@virgilio.it)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Flavio Stanchina wrote:
> On Sunday 03 November 2002 21:38, Nicholas Wourms wrote:
> 
> 
>>Stop whining, 2.5 kernels are development kernels -> not *expected* to
>>work %100!
> 
> 
> Correct me if I'm wrong, but we're here to work out the problems. That's 
> one of the major meanings of "development", in my experience.
> 
> I was bitten too: I loaded my 2.4.19 configuration and looked through most 
> options, but I overlooked this keyboard/mouse thing. I think it's not 
> turned on by default if you load an existing configuration, which is 
> probably not what we want.
> 

This is true, but if you are going to make a report, make a 
report, don't advocate changing something which works for 
most as it stands.  From the subject, one got the idea that 
people wanted to do some willy-nilly rearranging of the 
configure options.  The real issue here is that you really 
should *not* be copying 2.4 .config's over to a 2.5 tree. 
That way you'll be forced to go through all the options and 
get the proper "default" options for your platform enabled 
automatically.

Cheers,
Nicholas

