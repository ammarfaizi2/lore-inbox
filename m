Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264919AbUFRBeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264919AbUFRBeb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 21:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264924AbUFRBea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 21:34:30 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:49813 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264919AbUFRBdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 21:33:08 -0400
Message-ID: <40D2464D.2060202@opensound.com>
Date: Thu, 17 Jun 2004 18:33:01 -0700
From: 4Front Technologies <dev@opensound.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com> <20040618004450.GT12308@parcelfarce.linux.theplanet.co.uk> <40D23EBD.50600@opensound.com> <Pine.LNX.4.58.0406180313350.10292@scrub.local>
In-Reply-To: <Pine.LNX.4.58.0406180313350.10292@scrub.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel wrote:
> Hi,
> 
> On Thu, 17 Jun 2004, 4Front Technologies wrote:
> 
> 
>>It's time everybody started to pay some attention to in-kernel interfaces because
>>Linux has graduated out of your personal sandbox to where other people want to use
>>Linux and they aren't kernel developers.
> 
> 
> Look into your own diapers, learn the meaning of "documented interfaces" 
> and come back if you can show that SuSE broke exactly this.
> 
> bye, Roman
> 

Roman,

Like when did you start developing for Linux?. We go back as far as 1991. OK?
No need for such attacks. Look Andrew thinks we have a problem here and let's
work this issue out for the betterment of Linux.

The problem with SuSE is that /lib/modules/2.6.5-7.75/build is all screwy. Either
you do the right thing like Fedora or Redhat and ship the proper KBUILD environment
or link it to /usr/src/linux and atleast have the kernel headers intact.

Additionally, there are glaring problems with their headers. Why don't you
take a look at http://www.opensound.com/suse91diff.gz - it's a diff against
Linux 2.6.5 and it's 12.8Megs of diffs!. For heavens' sake, with so many diffs
they should be calling their kernel 3.x or something or stop using the Linux 2.6.xx naming
convention.


best regards
Dev Mazumdar
---------------------------------------------------------------------
4Front Technologies
4035 Lafayette Place, Unit F, Culver City, CA 90232, USA
Tel: 310 202 8530   Fax: 310 202 0496   URL: http://www.opensound.com
---------------------------------------------------------------------

