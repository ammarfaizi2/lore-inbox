Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290819AbSAaBsi>; Wed, 30 Jan 2002 20:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290821AbSAaBs2>; Wed, 30 Jan 2002 20:48:28 -0500
Received: from dsl-213-023-038-145.arcor-ip.net ([213.23.38.145]:12184 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S290819AbSAaBsN>;
	Wed, 30 Jan 2002 20:48:13 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Joe Thornber <thornber@fib011235813.fsnet.co.uk>,
        linux-kernel@vger.kernel.org, linux-lvm@sistina.com,
        lvm-devel@sistina.com
Subject: Re: [ANNOUNCE] LVM reimplementation ready for beta testing
Date: Thu, 31 Jan 2002 02:53:10 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020130202254.A7364@fib011235813.fsnet.co.uk>
In-Reply-To: <20020130202254.A7364@fib011235813.fsnet.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16W6PW-0000K0-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 30, 2002 09:22 pm, Joe Thornber wrote:
> The new kernel driver (known as "device-mapper") supports volume
> management in general and is no longer Linux LVM specific.
> As such it is a separate package from LVM2 which you will need
> to download and install before building LVM2.
> 
>  ftp://ftp.sistina.com/pub/LVM2/device-mapper/device-mapper-beta1.tgz

Hi, thanks a lot for this fine gift.  One small point: I downloaded these
files right away of course, then I renamed device-mapper-beta1.tgz as
LVM2-mapper-beta1.tgz, so I'd be able to find these things in my (very
full) download directory.  What do you think about doing it that way at
source?

> The userland tools are available from here:
> 
>  ftp://ftp.sistina.com/pub/LVM2/tools/LVM2.0-beta1.tgz

-- 
Daniel
