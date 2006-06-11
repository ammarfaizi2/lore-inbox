Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750858AbWFKT0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbWFKT0Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 15:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750859AbWFKT0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 15:26:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:15940 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750851AbWFKT0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 15:26:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cWzsm94lMimC6nGL4T7OxgkC359Hz0+G1JxP2C+uLSW+ng4gkgzt8I2AA15W6snehSeFpMT1b2kFlbmj5kmIyNcB2L9vt3KyUbAw04cNJ4KJIaufsWqtfClrY6O4jbbevtE85UavZEVVtfqVHgEUc2LV2f9dLCzo3jbDuZfYahU=
Message-ID: <5bdc1c8b0606111226r1438f12vb3c50df68bede9ec@mail.gmail.com>
Date: Sun, 11 Jun 2006 12:26:14 -0700
From: "Mark Knecht" <markknecht@gmail.com>
To: "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: 2.6.17-rc6-rt3
Cc: "Ingo Molnar" <mingo@elte.hu>, linux-kernel@vger.kernel.org
In-Reply-To: <1150046526.9122.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060610082406.GA31985@elte.hu>
	 <1149942743.8340.14.camel@Homer.TheSimpsons.net>
	 <1150029517.17158.38.camel@Homer.TheSimpsons.net>
	 <1150046526.9122.1.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/06, Thomas Gleixner <tglx@linutronix.de> wrote:

Just a quick note to say that 2.6.17-rc6-rt3 booted fine on my AMD64
box. Unlike rc6-rt1 this one will run X with no problems so far. Audio
is up, 1394 hard drives are fine, no xruns using Jack at 64/2. I'll
report back more if I run into any issues.

Great work!

mark@lightning ~ $ uname -a
Linux lightning 2.6.17-rc6-rt3 #4 PREEMPT Sun Jun 11 12:18:09 PDT 2006
x86_64 AMD Athlon(tm) 64 Processor 3000+ GNU/Linux
mark@lightning ~ $

Cheers,
Mark
