Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265754AbUBQByE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 20:54:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265953AbUBQByE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 20:54:04 -0500
Received: from mx-a.polytechnique.fr ([129.104.30.14]:6374 "EHLO
	mx-a.polytechnique.fr") by vger.kernel.org with ESMTP
	id S265754AbUBQByA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 20:54:00 -0500
From: antoine arnail <pep_lk@pep.homelinux.net>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.2 khubd oops
Date: Tue, 17 Feb 2004 02:49:37 +0100
User-Agent: KMail/1.6
Cc: Andrei Mikhailovsky <andrei@arhont.com>, linux-kernel@vger.kernel.org
References: <4030CA24.1090106@arhont.com> <20040216233656.GA23911@kroah.com>
In-Reply-To: <20040216233656.GA23911@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <200402170249.42439.pep_lk@pep.homelinux.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 17 Février 2004 00:36, Greg KH a écrit :
> On Mon, Feb 16, 2004 at 01:48:20PM +0000, Andrei Mikhailovsky wrote:
> > If anyone interested, I have an oops everytime i use and disconnect a
> > scanner device
>
> That's one reason why this driver is now gone from the kernel tree.
> Please do not use it anymore, it is not needed.
Are ou sure? 
My scanner works well (excepted if i unplug it-> kernel oops) with the 
deprecated module and isn't reconised without.

I have usb libraries and  hotplug installed, and i am running kernel 2.6.2 
also.

I am sorry but I will use this deprecated module until my scanner is reconised 
without.


-- 
Antoine Arnail <pep_lk@pep.homelinux.net>
