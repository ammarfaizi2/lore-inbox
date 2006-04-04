Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWDDAQS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWDDAQS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 20:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbWDDAQS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 20:16:18 -0400
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:38161 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S964907AbWDDAQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 20:16:18 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: Patch for AICA sound support on SEGA Dreamcast
Date: Tue, 4 Apr 2006 01:16:13 +0100
User-Agent: KMail/1.9.1
Cc: Carlos Munoz <carlos@kenati.com>,
       Adrian McMenamin <adrian@mcmen.demon.co.uk>,
       Alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-sh <linuxsh-dev@lists.sourceforge.net>,
       Paul Mundt <lethal@linux-sh.org>, LKML <linux-kernel@vger.kernel.org>
References: <1144075522.11511.20.camel@localhost.localdomain> <443162B4.60500@kenati.com> <s5hzmj28q8k.wl%tiwai@suse.de>
In-Reply-To: <s5hzmj28q8k.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604040116.13732.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 April 2006 19:32, Takashi Iwai wrote:
> At Mon, 03 Apr 2006 11:00:20 -0700,
>
> Carlos Munoz wrote:
> > Takashi Iwai wrote:
> > >Please avoid use of typedefs as much as possible.
> > >We (finally :-) got rid of whole typedefs recently from the ALSA core
> > >code.
> >
> > Hi Takashi,
> >
> > Just out of curiosity. What is the reason for no using typedefs ?
>
> Just to follow the convention of coding style in kernel tree.
>
> There are some reasons that typedefs are evil, but I don't want to
> start flames :)

I also do not wish to start a flame war, but I will direct Carlos to this URL:

http://www.linuxjournal.com/article/5780

I think this write-up provides justification. However, it is not part of 
linux/Documentation/CodingStyle. Perhaps somebody should add these details to 
this file, so that new code follows this currently 'unwritten' rule.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
