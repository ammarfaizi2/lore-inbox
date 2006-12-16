Return-Path: <linux-kernel-owner+w=401wt.eu-S1161308AbWLPSEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161308AbWLPSEs (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 13:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161303AbWLPSEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 13:04:48 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:42454 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161308AbWLPSEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 13:04:47 -0500
Date: Sat, 16 Dec 2006 19:03:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Tomas Carnecky <tom@dbservice.com>
cc: Alexey Dobriyan <adobriyan@gmail.com>,
       James Porter <jameslporter@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Binary Drivers
In-Reply-To: <4583527D.4000903@dbservice.com>
Message-ID: <Pine.LNX.4.61.0612161900090.30896@yvahk01.tjqt.qr>
References: <loom.20061215T220806-362@post.gmane.org>
 <20061215220117.GA24819@martell.zuzino.mipt.ru> <4583527D.4000903@dbservice.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 16 2006 01:57, Tomas Carnecky wrote:
> Alexey Dobriyan wrote:
>> On Fri, Dec 15, 2006 at 09:20:58PM +0000, James Porter wrote:
>> > For what it's worth, I don't see any problem with binary drivers from
>> > hardware
>> > manufacturers.
>> 
>> Binary drivers from hardware manufacturers are crap. Learn it by heart.
>
> That's your personal opinion! A lot other people (including me) have had
> excellent experience with binary drivers!

Either way.

 *  NVIDIA blob on a desktop box

    Ability to deadlock the machine, proved so in the past, but
    has not happened >= 1.0.7xxx so far.


 *  Free "radeon" driver on a laptop

    The _second_ time (relative to starting the X binary) I switch
    from Xorg 6.x to the console, the screen fades from black to
    white. System remains operational, switching back to X gives me
    my graphics mode back, but no way to go back to console.



	-`J'
-- 
