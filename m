Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbWEBRBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbWEBRBD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 13:01:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964931AbWEBRBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 13:01:01 -0400
Received: from fmr17.intel.com ([134.134.136.16]:48864 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S964928AbWEBRBA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 13:01:00 -0400
Message-ID: <44579028.1020201@linux.intel.com>
Date: Tue, 02 May 2006 19:00:24 +0200
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
CC: greg@kroah.com, linux-pci@atrey.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org, airlied@linux.ie, pjones@redhat.com,
       akpm@osdl.org
Subject: Re: Add a "enable" sysfs attribute to the pci devices to allow userspace
 (Xorg) to enable devices without doing foul direct access
References: <1146300385.3125.3.camel@laptopd505.fenrus.org>	 <9e4733910605020938h6a9829c0vc70dac326c0cdf46@mail.gmail.com>	 <44578C92.1070403@linux.intel.com> <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com>
In-Reply-To: <9e4733910605020959k7aad853dn87d73348cbcf42cd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Smirl wrote:
> All of these have been proposed before.

I think you forgot to attach the patch

> In my opinion an 'enable'
> attribute is the worst solution in the bunch.

you again limit yourself to VGA. I don't.
