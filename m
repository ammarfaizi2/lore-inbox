Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292784AbSB0T1d>; Wed, 27 Feb 2002 14:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292897AbSB0T1L>; Wed, 27 Feb 2002 14:27:11 -0500
Received: from flaxian.hitnet.RWTH-Aachen.DE ([137.226.181.79]:34566 "EHLO
	moria.gondor.com") by vger.kernel.org with ESMTP id <S292899AbSB0T0s>;
	Wed, 27 Feb 2002 14:26:48 -0500
Date: Wed, 27 Feb 2002 20:26:34 +0100
From: Jan Niehusmann <jan@gondor.com>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: IDE error on 2.4.17
Message-ID: <20020227192634.GA10397@gondor.com>
In-Reply-To: <20020227184758.GA9260@gondor.com> <Pine.LNX.4.10.10202271052360.19407-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10202271052360.19407-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 10:53:41AM -0800, Andre Hedrick wrote:
> Did you enable smart?
> Did you run the captive smart tests?

I only ran ide-smart /dev/hdx on the drive, and got a list of 'Passed'
tests. Do I need to enable something else for ide-smart to work? 
What are the captive smart tests?

Jan

