Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291036AbSBGBIL>; Wed, 6 Feb 2002 20:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291027AbSBGBIB>; Wed, 6 Feb 2002 20:08:01 -0500
Received: from [63.231.122.81] ([63.231.122.81]:44641 "EHLO lynx.adilger.int")
	by vger.kernel.org with ESMTP id <S291019AbSBGBHy>;
	Wed, 6 Feb 2002 20:07:54 -0500
Date: Wed, 6 Feb 2002 18:07:39 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: mumismo <mumismo@wanadoo.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel hotplug
Message-ID: <20020206180739.K15496@lynx.turbolabs.com>
Mail-Followup-To: mumismo <mumismo@wanadoo.es>,
	linux-kernel@vger.kernel.org
In-Reply-To: <GR4YZ6$IaNaxbYS7pHDy2KXFL5wNL4Sbf6iJS4Wb@wanadoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <GR4YZ6$IaNaxbYS7pHDy2KXFL5wNL4Sbf6iJS4Wb@wanadoo.es>; from mumismo@wanadoo.es on Thu, Feb 07, 2002 at 01:06:42AM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 07, 2002  01:06 +0100, mumismo wrote:
> I just want to ask if someone is working or has worked in changing a kernel 
> for another one without the need of rebooting the machine
> I think it has a couple of practical purporses:
> - Letting add new features as new drivers for hotplug devices , you can argue 
> that compilation of modules are enough but think in big kernel number changes 
> when you can't use that drivers so you have to reboot to install a new usb 
> HW. Pretty windows-like...
> - Letting change kernel for instance 2.4.0 --> 2.4.17, maybe you have a 
> machine working fine but with some problems sometimes with memory and you 
> have realized that the 2.4.17 mm works much finer. It's logical be able to 
> change it without rebooting (maybe you are in a 24x7 enviroment or you want 
> to beat some uptime record)

This is an old idea and is basically not possible to do, nor would you
actually want to do it in real life.  Please see:
http://marc.theaimsgroup.com/?l=linux-kernel&m=99489535607340&w=4

for a link to the last time this thread came up on l-k.  Maybe it is a time
for a FAQ entry?

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

