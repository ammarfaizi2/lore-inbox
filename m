Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280873AbRKGRoD>; Wed, 7 Nov 2001 12:44:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280875AbRKGRny>; Wed, 7 Nov 2001 12:43:54 -0500
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:8715 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S280873AbRKGRnn>;
	Wed, 7 Nov 2001 12:43:43 -0500
Date: Wed, 7 Nov 2001 10:43:13 -0800
From: Greg KH <greg@kroah.com>
To: Stephan Gutschke <stephan@gutschke.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops when syncing Sony Clie 760 with USB cradle
Message-ID: <20011107104313.E20648@kroah.com>
In-Reply-To: <E160obZ-0001bO-00@janus> <20011105131014.A4735@kroah.com> <3BE7F362.1090406@gutschke.com> <20011106095527.A10279@kroah.com> <3BE870EF.2080508@gutschke.com> <20011106155934.B12661@kroah.com> <3BE87C46.3050500@gutschke.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE87C46.3050500@gutschke.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Wed, 10 Oct 2001 16:33:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 07, 2001 at 01:11:50AM +0100, Stephan Gutschke wrote:
> sure i try a patch no problem. Especially because my Clie just did a 
> hard-reset :-( -- no clue why --  But I am glad when the syncing works
> again so i can get my data back on ;-)

Hm, in thinking about it, you should be able to sync right now by
talking to /dev/ttyUSB0 instead of /dev/ttyUSB1.

Let me know if this works or not.

thanks,

greg k-h
