Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbVC3Vtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbVC3Vtg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 16:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262362AbVC3Vsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 16:48:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:21187 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262326AbVC3Vr3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 16:47:29 -0500
Message-ID: <424B1E5A.5080309@pobox.com>
Date: Wed, 30 Mar 2005 16:47:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Francois Romieu <romieu@fr.zoreil.com>
CC: Andi Kleen <ak@muc.de>, Asfand Yar Qazi <ay1204@qazi.f2s.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
References: <4242865D.90800@qazi.f2s.com> <20050324093032.GA14022@havoc.gtf.org> <20050324162706.GJ17865@csclub.uwaterloo.ca> <42432A9F.3090507@pobox.com> <m1ekdz3hz0.fsf@muc.de> <424B013B.3010109@pobox.com> <20050330210646.GA26746@electric-eye.fr.zoreil.com>
In-Reply-To: <20050330210646.GA26746@electric-eye.fr.zoreil.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Francois Romieu wrote:
> Jeff Garzik <jgarzik@pobox.com> :
> 
>>Andi Kleen wrote:
> 
> [r8169 driver]
> 
>>>It does not seem to support DAC (or rather it breaks with DAC enabled), 
>>>which makes it not very useful on any machine with >3GB of memory.
>>
>>Driver bug.  I can futz with it and get it to do 64-bit on my Athlon64.
> 
> 
> Care to send a patch ?

Not globally applicable, judging from the reports :(

	Jeff



