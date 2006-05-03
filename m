Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbWECGCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbWECGCq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 02:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbWECGCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 02:02:46 -0400
Received: from fmr19.intel.com ([134.134.136.18]:51863 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S965097AbWECGCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 02:02:45 -0400
Message-ID: <4458475F.3010203@linux.intel.com>
Date: Wed, 03 May 2006 08:02:07 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: Dave Airlie <airlied@gmail.com>, greg@kroah.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       airlied@linux.ie, pjones@redhat.com, akpm@osdl.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace
 (Xorg) to enable devices without doing foul direct access
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>	 <9e4733910605020938h6a9829c0vc70dac326c0cdf46@mail.gmail.com>	 <44578C92.1070403@linux.intel.com>	 <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com>	 <44579028.1020201@linux.intel.com>	 <9e4733910605021013h17b72453v3716f68a2cebdee1@mail.gmail.com>	 <1146594457.32045.91.camel@laptopd505.fenrus.org>	 <9e4733910605021200y6333a67sd2ff685f666cc6f9@mail.gmail.com>	 <21d7e9970605021440s6cdc3895t57617e5fad6c5050@mail.gmail.com> <9e4733910605021452r3aec1035pa475b701b2c3563c@mail.gmail.com>
In-Reply-To: <9e4733910605021452r3aec1035pa475b701b2c3563c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> On 5/2/06, Dave Airlie <airlied@gmail.com> wrote:
>> Jon stop being so dramatic, this is just like letting userspace map
>> the BARs, without ownership through sysfs, which is a good thing, you
>> can still map /dev/mem, look we have lots of ways to shoot ourselves
>> in the foot, if we *want* to.
> 
> So why don't we just build a VGA class driver or make null fbdev

I think your mail client is defective, you somehow managed to not attach the patch *again*.
