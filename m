Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750734AbWCIXAI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750734AbWCIXAI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 18:00:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750742AbWCIXAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 18:00:08 -0500
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]:8630
	"EHLO mognix.dark-green.com") by vger.kernel.org with ESMTP
	id S1750734AbWCIXAG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 18:00:06 -0500
Message-ID: <4410B373.50906@dark-green.com>
Date: Fri, 10 Mar 2006 00:00:03 +0100
From: gimli <gimli@dark-green.com>
User-Agent: Mail/News 1.5 (X11/20060206)
MIME-Version: 1.0
To: "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       mactel-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Mactel-linux-devel] Re: [PATCH] /sys/firmware/efi/systab giving
 incorrect value for smbios
References: <D36CE1FCEFD3524B81CA12C6FE5BCAB00CA2309B@fmsmsx406.amr.corp.intel.com>
In-Reply-To: <D36CE1FCEFD3524B81CA12C6FE5BCAB00CA2309B@fmsmsx406.amr.corp.intel.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest mm patches makes the kernel unbootable on ma iMac.

cu

Edgar (gimli) Hucek

Tolentino, Matthew E wrote:
> gimli <> wrote:
>> Hi.
>>
>> Do you have any idea why the kernel crashes on machines with more
>> then 512 MB ram ? 
>>
> 
> Can you try the latest -mm with the attached patch on your machine?   
> This should fix it.  
> 
> matt

