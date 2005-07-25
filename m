Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261467AbVGYTUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261467AbVGYTUA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVGYTT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:19:59 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:42979 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261467AbVGYTSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:18:39 -0400
Subject: Re: xor as a lazy comparison
From: Lee Revell <rlrevell@joe-job.com>
To: Philippe Troin <phil@fifi.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Bernd Petrovitsch <bernd@firmix.at>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Grant Coady <lkml@dodo.com.au>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Puneet Vyas <vyas.puneet@gmail.com>
In-Reply-To: <87ackaitlj.fsf@ceramic.fifi.org>
References: <Pine.LNX.4.61.0507241835360.18474@yvahk01.tjqt.qr>
	 <kis7e1d4khtde78oajl017900pmn9407u4@4ax.com>
	 <Pine.LNX.4.61.0507242342080.9022@yvahk01.tjqt.qr>
	 <42E4131D.6090605@gmail.com> <1122281833.10780.32.camel@tara.firmix.at>
	 <1122314150.6019.58.camel@localhost.localdomain>
	 <1122318659.1472.14.camel@mindpipe>  <87ackaitlj.fsf@ceramic.fifi.org>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 15:18:37 -0400
Message-Id: <1122319117.1472.15.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-25 at 12:16 -0700, Philippe Troin wrote:
> Lee Revell <rlrevell@joe-job.com> writes:
> 
> > On Mon, 2005-07-25 at 13:55 -0400, Steven Rostedt wrote: 
> > > Doesn't matter. The cycles saved for old compilers is not rational to
> > > have obfuscated code.
> > 
> > Where do we draw the line with this?  Is x *= 2 preferable to x <<= 2 as
> > well?
> 
> Depends if you want to multiply by 2 or 4 :-)

I guess I just answered my own question ;-)

Lee

