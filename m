Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262172AbVAUAUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVAUAUN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 19:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVAUAST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 19:18:19 -0500
Received: from main.gmane.org ([80.91.229.2]:38869 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261546AbVAUARN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 19:17:13 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: intel8x0 and 2.6.11-rc1
Date: Fri, 21 Jan 2005 02:16:49 +0200
Message-ID: <pan.2005.01.21.00.16.47.737170@yahoo.com>
References: <87hdlcc06e.fsf@topaz.mcs.anl.gov> <s5hfz0wrusn.wl@alsa2.suse.de> <878y6oaysw.fsf@topaz.mcs.anl.gov> <s5hbrbkrt6c.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: home-33027.b.astral.ro
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Takashi,

The same applies for IBM T40/T41/R50p I have tested so far.
I had to disable "Headphone Jack Sense" and "Line Jack Sense" too.
So, what's the deal with these ?
What are they supposed to do ?
Should we report this as bug on alsa lists ?

Thanks,
Paul

On Thu, 20 Jan 2005 16:55:55 +0100, Takashi Iwai wrote:
>>   If you have "Headphone Jack Sense" mixer control,
>>   try to turn it off.
>> 
>> That did the trick. thanks..
> 
> Glad to hear that.  What machine do you have?


