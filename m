Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265667AbTAFBc1>; Sun, 5 Jan 2003 20:32:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265670AbTAFBcZ>; Sun, 5 Jan 2003 20:32:25 -0500
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:11269 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265633AbTAFBcX> convert rfc822-to-8bit; Sun, 5 Jan 2003 20:32:23 -0500
Content-Type: text/plain; charset=US-ASCII
From: Roberto Peon <robertopeon@sportvision.com>
Organization: Sportvision
To: linux-kernel@vger.kernel.org
Subject: aic79xx bug? my stupidity?
Date: Sun, 5 Jan 2003 20:40:54 -0500
User-Agent: KMail/1.4.3
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com> <1041166487.1338.1.camel@laptop.fenrus.com> <610650816.1041607684@aslan.scsiguy.com>
In-Reply-To: <610650816.1041607684@aslan.scsiguy.com>
Cc: "Justin T. Gibbs" <gibbs@scsiguy.com>, linux-scsi@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301052040.54974.robertopeon@sportvision.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure to whom I should be addressing this, but it seems that
Justin Gibbs is one of those people.


I've been trying to get the aic79xx driver working in 2.4.19 without success.
I'll clarify:

I've extracted the source tarfile into the kernel dist directory, config'd the
module to build, built it, installed it, etc.

I've gotten far enough that I can get the kernel to boot with it, and it seems
to see the controller, however, I cannot get it to find the root partition.

I have had success using redhat and the driver diskette.
The hardware is an aic7902, integrated onto a Supermicro X5DA8.


>From what I could find on the archives, it seemed like a patch might be
needed to get a vanilla kernel up&running with the aic79xx driver. Is this
right? If so, where might that patch be?

I have more questions and possibly a bug, but would like to find the proper
people to speak with before burdening the list with tons of data.

-Roberto J Peon
robertopeon@sportvision.com
