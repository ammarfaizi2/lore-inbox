Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272224AbTG3WqH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 18:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272279AbTG3WqH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 18:46:07 -0400
Received: from smtp-node1.eclipse.net.uk ([212.104.129.76]:35342 "EHLO
	smtp1.ex.eclipse.net.uk") by vger.kernel.org with ESMTP
	id S272224AbTG3WqE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 18:46:04 -0400
From: Ian Hastie <ianh@iahastie.clara.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0t2 Hangs randomly
Date: Wed, 30 Jul 2003 23:46:01 +0100
User-Agent: KMail/1.5.2
References: <3F27817A.8000703@gts.it>
In-Reply-To: <3F27817A.8000703@gts.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307302346.02989.ianh@iahastie.local.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 Jul 2003 09:27, Stefano Rivoir wrote:
> I'm experiencing hard rand lockups using kernel 2.6.0: they are not
> predictable, nor I can find a way to reproduce them. They can occur
> while working with an app, while browsing the fs (I use KDE) or
> while resuming after the screensaver, or anything else. They can
> occur after one hour or 15 minutes, and there's not any strange
> "jerkiness" activity before, nor an intense disk work.
>
> After the hang, the disk starts working for a while, then I have
> to reset w/button, and nothing is left on the various system logs.

What makes you think this is a hang?  Does the disc activity stop?  If you 
press the caps lock or num lock keys does the LED light up?  What I'm asking 
is could it have been swapping for some reason?  I've had the system go 
unresponsive on me quite recently, also when running KDE.  It easilly took a 
two or more minutes to start responding again.  The disc light stayed active 
all the time it wasn't responding.

-- 
Ian.

