Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317469AbSHCFG5>; Sat, 3 Aug 2002 01:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317493AbSHCFG5>; Sat, 3 Aug 2002 01:06:57 -0400
Received: from webmail10.rediffmail.com ([202.54.124.179]:15253 "HELO
	webmail10.rediffmail.com") by vger.kernel.org with SMTP
	id <S317489AbSHCFG4>; Sat, 3 Aug 2002 01:06:56 -0400
Date: 3 Aug 2002 05:09:51 -0000
Message-ID: <20020803050951.4782.qmail@webmail10.rediffmail.com>
MIME-Version: 1.0
From: "Enugala Venkata Ramana" <caps_linux@rediffmail.com>
Reply-To: "Enugala Venkata Ramana" <caps_linux@rediffmail.com>
To: "Brad Hards" <bhards@bigpond.net.au>
Cc: linux-kernel@vger.kernel.org, "Greg KH" <greg@kroah.com>
Subject: Re: Re: installation of latest kernel on compaq notebook
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi ,
Using the make xconfig. i cannot even select it.
Regards
Venku.
On Sat, 03 Aug 2002 Brad Hards wrote :
>On Sat, 3 Aug 2002 14:12, Enugala Venkata Ramana wrote:
> > Hi Greg,
> >   I tried to configure my kernel. But when ever i try with 
>kerel
> > 2.4.xx i always find the catc driver for the usb is not 
>enabled. I
> > cannot add that into my kernel at all.can u please let me 
>know
> > what needs to be done in this is situation and what is the 
>kernal
> > version from which it is been enabled.
>The use of "enabled" is confusing me. You aren't describing
>the problem very well.
>
>Do you mean that you cannot select in when you are doing
>a "make menuconfig" or "make xconfig"?
>
>Or do you mean that you have selected it, but it isn't being
>compiled?
>
>Or do you mean that you have it compiled, but the kernel
>won't boot (or you can't modprobe the module)?
>
>Or do you mean that it boots and the kernel shows
>the catc driver (in /proc/bus/usb/drivers) but the
>device isn't being claimed (as shown in /proc/bus/usb/devices).
>
>Exactly what are you trying to do, and what is happening?
>
>Brad
>
>--
>http://conf.linux.org.au. 22-25Jan2003. Perth, Australia. Birds 
>in Black.

__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/

