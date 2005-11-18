Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbVKRSge@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbVKRSge (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 13:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161080AbVKRSge
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 13:36:34 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:33415 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1161114AbVKRSgd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 13:36:33 -0500
Date: Fri, 18 Nov 2005 19:36:07 +0100
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Sylvain Meyer <sylvain.meyer@worldonline.fr>
Subject: Re: X and intelfb fight over videomode
Message-ID: <20051118183607.GA3866@hardeman.nu>
References: <20051117000144.GA29144@hardeman.nu> <437BD8D9.9030904@gmail.com> <20051117014558.GA30088@hardeman.nu> <437C0BF2.4010400@gmail.com> <20051117234510.GA3854@hardeman.nu> <437D298A.7070203@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
In-Reply-To: <437D298A.7070203@gmail.com>
User-Agent: Mutt/1.5.11
Content-Transfer-Encoding: 8BIT
X-SA-Score: -2.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2005 at 09:08:26AM +0800, Antonino A. Daplas wrote:
>David Härdeman wrote:
>> First time I switch from X to VC:
>> intelfb: Changing the video mode is not supported.
>> intelfb: ring buffer : space: 6024 wanted 65472
>> intelfb: lockup - turning off hardware acceleration
>> 
>
>Well, intelfb is at the mercy of X if it's in 'fixed mode'.
>
>> Other suggestions?
>
>I'm adding Sylvain, the intelfb maintainer, to the CC list.
>
>How about this one?  It also resets the ringbuffer before re-initializing
>it again.

That made no change at all unfortunately, the messages are exactly the 
same as before...

//David
