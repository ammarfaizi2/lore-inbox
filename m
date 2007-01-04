Return-Path: <linux-kernel-owner+w=401wt.eu-S965122AbXADW3P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965122AbXADW3P (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 17:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965127AbXADW3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 17:29:15 -0500
Received: from smtp-out.coditel.net ([212.95.66.33]:36510 "EHLO
	smtp-out.coditel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965122AbXADW3O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 17:29:14 -0500
X-Greylist: delayed 1698 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Jan 2007 17:29:14 EST
Date: Thu, 4 Jan 2007 23:00:42 +0100 (CET)
From: Mich Lanners <mlan@cpu.lu>
Subject: Re: [RFC: 2.6 patch] remove the broken VIDEO_PLANB driver
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Adrian Bunk <bunk@stusta.de>
Cc: linuxppc-dev@ozlabs.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org, mchehab@infradead.org
In-Reply-To: <1167946479.5273.18.camel@localhost.localdomain>
Message-ID: <tkrat.5fdfdb1db356c580@cpu.lu>
References: <20070104185323.GF20714@stusta.de>
 <1167946479.5273.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
X-AV-Checked: clean on smtp.coditel.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian, hi Ben,

On   5 Jan, this message from Benjamin Herrenschmidt echoed through
cyberspace:
> On Thu, 2007-01-04 at 19:53 +0100, Adrian Bunk wrote:
>> The VIDEO_PLANB driver:
>> - has been marked as BROKEN for more than two years and
>> - is still marked as BROKEN.
>> 
>> Drivers that had been marked as BROKEN for such a long time seem to
>> be unlikely to be revived in the forseeable future.

I was waiting for this one :-) I have to admit I don't have the time to
work on this anymore, so either Ben can fix something, or I will sadly
add my s-o-b.

>> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> I suppose I could give it a go as I do have a machine with that
> hardware rusting somewhere... Don't remove it right away, I'll have a
> look.

If you need explanations about the code or the hardware, don't hesitate
to ask. Not sure what I still remember, but I still have my old paper
notes.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "
