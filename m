Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbVGCTd1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbVGCTd1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 15:33:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbVGCTd1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 15:33:27 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:49616
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S261506AbVGCTap (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 15:30:45 -0400
Message-ID: <42C82E75.7070108@linuxwireless.org>
Date: Sun, 03 Jul 2005 13:29:09 -0500
From: Alejandro Bonilla <abonilla@linuxwireless.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Hansen <dave@sr71.net>
CC: Jesper Juhl <jesper.juhl@gmail.com>, Vojtech Pavlik <vojtech@suse.cz>,
       Pavel Machek <pavel@suse.cz>, Paul Sladen <thinkpad@paul.sladen.org>,
       linux-thinkpad@linux-thinkpad.org,
       Eric Piel <Eric.Piel@tremplin-utc.net>, borislav@users.sourceforge.net,
       Yani Ioannou <yani.ioannou@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hdaps-devel@lists.sourceforge.net
Subject: Re: [Hdaps-devel] Re: [ltp] IBM HDAPS Someone interested?	(Accelerometer)
References: <1119559367.20628.5.camel@mindpipe>	 <Pine.LNX.4.21.0506250712140.10376-100000@starsky.19inch.net>	 <20050625144736.GB7496@atrey.karlin.mff.cuni.cz>	 <42BD9EBD.8040203@linuxwireless.org> <20050625200953.GA1591@ucw.cz>	 <42C7A3B2.4090502@linuxwireless.org> <20050703101613.GA2372@ucw.cz>	 <9a8748490507030407547fa29b@mail.gmail.com>  <42C82BBB.9090008@gmail.com> <1120418514.4351.6.camel@localhost>
In-Reply-To: <1120418514.4351.6.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:

>On Sun, 2005-07-03 at 20:17 +0200, Jesper Juhl wrote:
>  
>
>>Ok, just to show you people what I've done so far.
>>This doesn't work yet, but it should be resonably close (at least it
>>builds ;)
>>    
>>
>
>On top of what you sent at first this morning (not the most recent one)
>I did some stuff (in the attached patch).  It implements the last bit of
>initialization that your earlier one didn't do, but I see you've done in
>the most recent one.
>
>Anyway, I get 10 reads out of it, 1 second apart, and it appears to be
>getting real data:
>
>10 seconds while tilting my thinkpad around:
>
>x_accel: 372
>y_accel: 339
>x_accel: 475
>  
>
Dave,

Simply awesome. Could you please send me the complete source that you 
have? Maybe also cc hdaps mailing list?

It's appreciated.

or, is this patch against Brix source?

.Alejandro
