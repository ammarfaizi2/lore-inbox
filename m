Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292886AbSB0Sss>; Wed, 27 Feb 2002 13:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292464AbSB0SsU>; Wed, 27 Feb 2002 13:48:20 -0500
Received: from flaxian.hitnet.RWTH-Aachen.DE ([137.226.181.79]:60165 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S292888AbSB0SsE>;
	Wed, 27 Feb 2002 13:48:04 -0500
Date: Wed, 27 Feb 2002 19:47:58 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: IDE error on 2.4.17
Message-ID: <20020227184758.GA9260@gondor.com>
In-Reply-To: <20020227102544.GA3226@codepoet.org> <E16g5YG-0004gk-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16g5YG-0004gk-00@the-village.bc.nu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 02:59:28PM +0000, Alan Cox wrote:
> This is the wrong approach. That information is available properly if and
> when the vendors install the smart utilities

Doesn't necessarily help. I recently saw a hard drive which made funny
noises and got really slow reading some parts of the drive (~30MB/s on
some parts, ~300kB/s on others), but ide-smart didn't report failed
tests. Two days later the drive was dead...

It was an IBM 60GB drive, but I don't remember the exact type. It
called itself "IC35L060AVER07-0".

Jan

