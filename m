Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312996AbSDDAos>; Wed, 3 Apr 2002 19:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313035AbSDDAoi>; Wed, 3 Apr 2002 19:44:38 -0500
Received: from imladris.infradead.org ([194.205.184.45]:34822 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S312996AbSDDAoe>; Wed, 3 Apr 2002 19:44:34 -0500
Date: Thu, 4 Apr 2002 01:44:32 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Alfonso Gazo <agazo@unex.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.18] /proc/stat does not show disk_io stats for all IDE disks
Message-ID: <20020404014432.A9917@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Alfonso Gazo <agazo@unex.es>, linux-kernel@vger.kernel.org
In-Reply-To: <3CAB7C24.58E63B12@unex.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 04, 2002 at 12:03:16AM +0200, Alfonso Gazo wrote:
> Hi everyone,
> 
> After installing noflushd daemon, I noticed it couldn't access the
> disk_io stats for all IDE disks attached to my system, but only the
> attached to the motherboard IDE controller. The ones that doesn't appear
> in /proc/stat are the disks attached to a Promise Ultra66 PCI IDE card.
> I reproduced this problem with 2.4.18, 2.4.17 and 2.4.7 kernels.

Could you please tru 2.4.18-ac/2.4.19-ac?
