Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVGTKDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVGTKDg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 06:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVGTKDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 06:03:32 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:33216 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261468AbVGTKDb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 06:03:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=FXzZR+f1Odd/DSJclXmSPgLCzfYvFJSkRcoJC/ewHMg/JGqR4NDpvu7yLE+ULtuY+8KzV4fAO6COPRaM6gXEIcF5VDRqNGDnCkxQ8XckEhnaMvi37GMBWPwRhNIUnv7JcrWMHe9fKqfsmfLJ07aT6Z1ffXYPIScznq45EFB+BmA=
Message-ID: <fc339e4a0507200302d9f0141@mail.gmail.com>
Date: Wed, 20 Jul 2005 19:02:53 +0900
From: Miles Bader <snogglethorpe@gmail.com>
Reply-To: snogglethorpe@gmail.com, miles@gnu.org
To: Jan Dittmer <jdittmer@ppp0.net>
Subject: Re: defconfig for v850, please
Cc: miles@gnu.org, linux-kernel@vger.kernel.org
In-Reply-To: <42DE1DDE.90503@ppp0.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42DE17DC.7050506@ppp0.net>
	 <fc339e4a05072002355e4062d6@mail.gmail.com> <42DE1DDE.90503@ppp0.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2005/7/20, Jan Dittmer <jdittmer@ppp0.net>:
> > I must admit it's because I've never quite understood how the
> > defconfig stuff works... I'll look into it I guess...
> 
> I think you just need to provide a file called 'defconfig' in
> arch/v850/

Hmmm...

Some archs seem to provide defconfigs for various different platforms,
which seems nice, and there seems to be some sort of framework for
doing this, but ...

-Miles
-- 
Do not taunt Happy Fun Ball.
