Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319553AbSIHBZy>; Sat, 7 Sep 2002 21:25:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319555AbSIHBZx>; Sat, 7 Sep 2002 21:25:53 -0400
Received: from mail.getnet.net ([216.19.223.10]:51269 "HELO mail.getnet.net")
	by vger.kernel.org with SMTP id <S319553AbSIHBZw>;
	Sat, 7 Sep 2002 21:25:52 -0400
Message-ID: <3D7AA839.8040805@getnet.net>
Date: Sat, 07 Sep 2002 18:30:33 -0700
From: Art Wagner <awagner@getnet.net>
Reply-To: awagner@getnet.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2a) Gecko/20020907
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bob McElrath <mcelrath+kernel@draal.physics.wisc.edu>
CC: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: ide-scsi oops
References: <20020907183328.GB5985@draal.physics.wisc.edu> <Pine.LNX.4.10.10209071143080.16589-100000@master.linux-ide.org> <20020908005032.GB4828@draal.physics.wisc.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have found most of my problems with ide CD-R and CDRW answered by the
CD-Writing-HOWTO from;
http://www.linuxdoc.org/

Bob McElrath wrote:
> Andre Hedrick [andre@linux-ide.org] wrote:
> 
>>On Sat, 7 Sep 2002, Bob McElrath wrote:
>>
>>Would you pass hdc=scsi for the next reboot?
> 
> 
> As this is an IDE device I'm not sure what hdc=scsi should do...
> 
> However that seems to get rid of the oops.  It appears to operate
> normally (I can mount CD's, DVD's, play DVD's, and play CD's).
> cdparanoia even works (with no sg module installed -- which I thought it
> needed) though while it's running the CPU usage jumps to 100%.  :(
> 
> I see that the Configure.help now says to use "hdx=scsi".  I am not sure
> where I received the information to use "hdx=ide-scsi" but that did work
> with kernel 2.4.18.
> 
> Cheers,
> -- Bob
> 
> Bob McElrath
> Univ. of Wisconsin at Madison, Department of Physics
> 
> "No nation could preserve its freedom in the midst of continual warfare."
>     --James Madison, April 20, 1795
I have found most of my questions on ide-scsi answered in the

