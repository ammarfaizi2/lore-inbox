Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279829AbRKAWkL>; Thu, 1 Nov 2001 17:40:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279830AbRKAWkD>; Thu, 1 Nov 2001 17:40:03 -0500
Received: from chunnel.redhat.com ([199.183.24.220]:7422 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S279829AbRKAWjx>; Thu, 1 Nov 2001 17:39:53 -0500
Date: Thu, 1 Nov 2001 22:37:48 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Joan Batet <j.batet@barcelo.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, ext3-users@redhat.com,
        Stephen Tweedie <sct@redhat.com>
Subject: Re: HIGMEM, SMP, 2.4.13 and Cerberus
Message-ID: <20011101223748.A5289@redhat.com>
In-Reply-To: <20011031150453.52C3D52DF0@uphill.barcelo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011031150453.52C3D52DF0@uphill.barcelo.com>; from j.batet@barcelo.com on Wed, Oct 31, 2001 at 04:06:31PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 31, 2001 at 04:06:31PM +0100, Joan Batet wrote:
> As you suggested, I ran the test again with Linux-2.4.12-ac6, 
> Linux-2.4.13-ac4 and Linux-2.4.13, this time with ext2 filesystem (the 
> previous cerberus run was run on ext3 partitions).

How does ext3 look on 2.4.12-ac6?  Pretty much all of the VM testing
we've done on ext3 has been on Rik's VM as still present in the -ac
tree.

Cheers,
 Stephen
