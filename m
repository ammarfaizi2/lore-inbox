Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290666AbSBFQsJ>; Wed, 6 Feb 2002 11:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290665AbSBFQsB>; Wed, 6 Feb 2002 11:48:01 -0500
Received: from rgminet1.oracle.com ([148.87.122.30]:19935 "EHLO
	rgminet1.oracle.com") by vger.kernel.org with ESMTP
	id <S290671AbSBFQrR>; Wed, 6 Feb 2002 11:47:17 -0500
Message-ID: <3C615E5D.A0E0B6A7@oracle.com>
Date: Wed, 06 Feb 2002 17:48:29 +0100
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Support Services
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Applying 2.5.4-pre1 patch
In-Reply-To: <3C6119E2.2060504@wanadoo.fr> <3C612CEC.A3BEB92C@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Suardi wrote:
> 
> Pierre Rousselet wrote:
> >
> > Patching drivers/char/gameport with /dev/null doesn't work for me. What
> > is the trick ?
> 
> In my case has been
> 
>  - untar 2.5.3 in /usr/src/linux
>  - cd linux; ln -s linux a
>  - patch
>  - cd /usr/src; mv b/drivers/input/* /usr/src/linux/drivers/input
>  - build
> 
> I only have to reboot and see if it works :)
>

Hmm - oops on boot :( maybe later I'll have some time to repeat,
 copy down oops and decode it.

--alessandro

 "If your heart is a flame burning brightly
   you'll have light and you'll never be cold
  And soon you will know that you just grow / You're not growing old"
                              (Husker Du, "Flexible Flyer")
