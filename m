Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318365AbSHPNSn>; Fri, 16 Aug 2002 09:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318367AbSHPNSn>; Fri, 16 Aug 2002 09:18:43 -0400
Received: from freemail.agrinet.ch ([212.28.134.90]:12812 "EHLO
	FREEMAIL.agrinet.ch") by vger.kernel.org with ESMTP
	id <S318365AbSHPNSl>; Fri, 16 Aug 2002 09:18:41 -0400
Date: Fri, 16 Aug 2002 15:23:15 +0200
From: Andreas Tscharner <starfire@dplanet.ch>
To: Jean Delvare <khali@linux-fr.org>
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Bug in 2.4.19
Message-Id: <20020816152315.19a44435.starfire@dplanet.ch>
In-Reply-To: <20020816093847.4ae5544e.khali@linux-fr.org>
References: <20020816093847.4ae5544e.khali@linux-fr.org>
Organization: No Such Penguin
X-Mailer: Sylpheed version 0.8.1claws38 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Aug 2002 09:38:47 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> > After compiling 2.4.19 (Debian kernel-source-2.4.19-1), I've had
> > several kernel bugs. I've added the messages of two that I got in
> > the log. The others are similar. I re-changed to 2.4.18 (Debian
> > kernel-source-2.4.18-5) and everything works fine.
> 
> Are you able to reproduce the problem without loading the NVidia
> drivers? If no, you know who to complain to.

Hmm.
I don't know; gonna test it...
> 
> Second question, are the Zip100-drive-related errors in dmesg
> something unusual and thus probably related to the problem?
> 
> > I/O error: dev 08:00, sector 0
> > unable to read partition table

No, they are "normal". The ppa driver complains about not having a disk
in my ZIP drive

Regards
	Andreas
-- 
Andreas Tscharner                                  starfire@dplanet.ch
----------------------------------------------------------------------
"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the Universe trying
to produce bigger and better idiots. So far, the Universe is winning."
                                                          -- Rich Cook 
