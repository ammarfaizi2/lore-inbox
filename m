Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261208AbVFJUZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261208AbVFJUZl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 16:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261209AbVFJUZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 16:25:41 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:30350 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261208AbVFJUZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 16:25:36 -0400
Subject: RE: ipw2100: firmware problem
From: Lee Revell <rlrevell@joe-job.com>
To: abonilla@linuxwireless.org
Cc: "'Denis Vlasenko'" <vda@ilport.com.ua>, "'Pavel Machek'" <pavel@ucw.cz>,
       "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'Netdev list'" <netdev@oss.sgi.com>,
       "'kernel list'" <linux-kernel@vger.kernel.org>,
       "'James P. Ketrenos'" <ipw2100-admin@linux.intel.com>
In-Reply-To: <000f01c56dbf$9b15de90$600cc60a@amer.sykes.com>
References: <000f01c56dbf$9b15de90$600cc60a@amer.sykes.com>
Content-Type: text/plain
Date: Fri, 10 Jun 2005 16:26:27 -0400
Message-Id: <1118435188.6423.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.3.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-06-10 at 07:23 -0600, Alejandro Bonilla wrote:
> >
> > Adding kernel level wireless autoconfiguration duplicates the effort.
> > Since I am not going to give up a requirement to be able to stay radio
> > silent at boot (me too wants freedom, not only you), you need to add
> > disable=1 module parameter to each driver, which adds to the mess.
> >
> > ALSA does the Right Thing. Sound is completely muted out at
> > module load.
> > It's a user freedom to set desired volume level after that.
> 
> Yeah right. I remember I had to google for 10 minutes to find the answer for
> this one. Why would you install something, for it to not work?
> 
> It thing of Mute in ALSA is stupid. If you want Sound, you install the Sound
> and enable it. Why would it make you google for more things to do? ALSA mute
> on install is WAY way, not OK.

It took you 10 minutes of googling before you thought to try the mixer?
Sorry dude, this is PEBKAC.

Lee

