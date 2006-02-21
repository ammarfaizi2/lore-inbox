Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161248AbWBUXz4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161248AbWBUXz4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161252AbWBUXz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:55:56 -0500
Received: from main.gmane.org ([80.91.229.2]:27565 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161248AbWBUXzz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:55:55 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Tristan Wibberley <maihem@maihem.org>
Subject: Re: suspend2 review [was Re: Which is simpler? (Was Re: [Suspend2-devel]
 Re: [ 00/10] [Suspend2] Modules support.)]
Date: Tue, 21 Feb 2006 23:55:04 +0000
Message-ID: <dtg98o$315$1@sea.gmane.org>
References: <20060201113710.6320.68289.stgit@localhost.localdomain>	 <200602200709.17955.nigel@suspend2.net>	 <20060219234212.GA1762@elf.ucw.cz>	 <200602201210.58362.nigel@suspend2.net>	 <20060220124937.GB16165@elf.ucw.cz>	 <20060220170537.GB33155@dspnet.fr.eu.org>	 <1140559365.2742.80.camel@mindpipe> <d120d5000602211417se24ed51w15e0c5c95b69d58c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host81-151-156-100.range81-151.btcentralplus.com
User-Agent: Mail/News 1.5 (X11/20060213)
In-Reply-To: <d120d5000602211417se24ed51w15e0c5c95b69d58c@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> On 2/21/06, Lee Revell <rlrevell@joe-job.com> wrote:
>> On Mon, 2006-02-20 at 18:05 +0100, Olivier Galibert wrote:
>>> Pavel, if you mean that the userspace code will not be reviewed to
>>> standards the kernel code is, kill uswsusp _NOW_ before it does too
>>> much damage.  Unreliable suspend eats filesystems for breakfast.  The
>>> other userspace components of the kernels services are either optional
>>> (udev) or not that important (alsa).
>>>
>> Why is sound less important than suspending, or networking, or any other
>> subsystem?  This is an insult to everyone who worked long and hard to
>> get decent sound support on Linux.
>>
> 
> I bet this was not meant as an insult. Quote: "Unreliable suspend eats
> filesystems for breakfast". The worst thing mismatched ALSA library
> could cause is noice in my speakers.

If you've got a Linux powered stereo in your car, you're going like the 
clappers and your speakers suddenly blast out white noise as loud as 
they possibly can, you will wish you had enough seconds left to run a 
measly fsck.

-- 
Tristan Wibberley

