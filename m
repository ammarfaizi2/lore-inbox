Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbTJSPxu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 11:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261719AbTJSPxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 11:53:50 -0400
Received: from [65.248.109.119] ([65.248.109.119]:49554 "EHLO
	ns1.brianandsara.net") by vger.kernel.org with ESMTP
	id S261662AbTJSPxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 11:53:47 -0400
From: Brian Jackson <iggy@gentoo.org>
Organization: Gentoo Linux
To: Max Valdez <maxvaldez@yahoo.com>, kernel <linux-kernel@vger.kernel.org>
Subject: Re: nvidia.o on 2.4.22/2.6.0 ??
Date: Sun, 19 Oct 2003 10:53:46 -0500
User-Agent: KMail/1.5.9
References: <1066178010.14217.3.camel@garaged.fis.unam.mx>
In-Reply-To: <1066178010.14217.3.camel@garaged.fis.unam.mx>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200310191053.46675.iggy@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 October 2003 07:33 pm, Max Valdez wrote:
> Hi 
> 
> I know this is not really liked, but since I dont have a lot of money,
> and this is the only "good" video card I have.
> 
> Have anyone made a successful run of X with nvidia (closes source)
> module ??, I have a TNT2 running on a 2.4.20-gentoo-r7 kernel, but when
> I try to run X on 2.4.22* or 2.6.0* I alway get an error about my screen
> and /dev/nvidia0.
> 
> Is there any work on this ??, please dont tell me to change my video
> card, because I cant.

The gentoo nvidia-kernel package will apply the minion patch if you are 
running a 2.6 kernel, so there is no need to do all that by hand. Just make 
sure you run "emerge nvidia-kernel" for each new kernel.

--Iggy

> 
> Thanks in advance
> Max
> -- 
> Nunca ! Jamas !
> 

-- 
Home -- http://www.brianandsara.net
Gentoo -- http://gentoo.brianandsara.net
