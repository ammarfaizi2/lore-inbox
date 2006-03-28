Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWC1Q5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWC1Q5x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 11:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWC1Q5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 11:57:53 -0500
Received: from uproxy.gmail.com ([66.249.92.196]:13294 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750756AbWC1Q5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 11:57:52 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:content-transfer-encoding:in-reply-to:user-agent;
        b=V3LuJ+OX2GZi7JAQhn7s+T21mqp4/QX99K1uvHLXXUDhpTjmz09+3V2RqTyGB/zlo8mHYnaBn7pxoP6ChgQTrnuwk5jMAQ4XHao7GjsnJK9k/Z379G10CubyRoVdbwiLOhn55CNI1RlWnnOsdvOhZgeyZ9EnKGVBcut+EB6aq3Y=
Date: Tue, 28 Mar 2006 18:57:43 +0200
From: Friedrich =?iso-8859-1?Q?G=F6pel?= <shado23@gmail.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       alsa-user@lists.sourceforge.net, Lee Revell <rlrevell@joe-job.com>,
       Takashi Iwai <tiwai@suse.de>
Subject: Re: hda-intel woes
Message-ID: <20060328165743.GA4126@localhost.in.y0ur.4ss>
Mail-Followup-To: Kyle Moffett <mrmacman_g4@mac.com>,
	"Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
	LKML Kernel <linux-kernel@vger.kernel.org>,
	alsa-user@lists.sourceforge.net, Lee Revell <rlrevell@joe-job.com>,
	Takashi Iwai <tiwai@suse.de>
References: <20060327231049.GA30641@localhost.in.y0ur.4ss> <4428872E.3020308@wolfmountaingroup.com> <69495D2A-5488-428E-970F-EA4DD8CB4C05@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <69495D2A-5488-428E-970F-EA4DD8CB4C05@mac.com>
User-Agent: mutt-ng/devel-r790 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21:22 Mon 27 Mar     , Kyle Moffett wrote:
> Hi!  Unfortunately messages tend to get lost on occasion due to the sheer volume of email.  Sometimes you 
> may have to resend a couple times to get a response.  It also helps if you add relevant CC's from the 
> MAINTAINERS file (added to this message).  You can also file a bug report on the ALSA bug tracker, I think 
> the ALSA people tend to be fairly good about keeping up with that; sometimes more so than the mailing list.

Hi,

Thanks for the reply, but it seems I have wasted your time.
It works now that I upgraded the thing to 2.6.16 and alsa 1.0.11_rc4,
so I guess it's all fixed already. :)
I propably should have rechecked before resending the mail,
but I didn't notice there was a new alsa rc.

Anyway, well done, I'll mail if I should come across an actual bug. ;)


Cheers,

Friedrich Göpel
