Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316723AbSFKD2m>; Mon, 10 Jun 2002 23:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316682AbSFKD2l>; Mon, 10 Jun 2002 23:28:41 -0400
Received: from marc2.theaimsgroup.com ([63.238.77.172]:20490 "EHLO
	marc2.theaimsgroup.com") by vger.kernel.org with ESMTP
	id <S316723AbSFKD2l>; Mon, 10 Jun 2002 23:28:41 -0400
Date: Mon, 10 Jun 2002 23:28:42 -0400
Message-Id: <200206110328.g5B3SgL08447@marc2.theaimsgroup.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Locking CD tray w/o opening device
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-06-11, Nathan Neulinger <nneul@umr.edu> wrote:

> Is there any straightforward way of disabling the buttons on the CD and
> locking all the time? I'm not averse to an ugly hack to 2.4.18+ source
> if necessary.

I'm not sure exactly what you mean.  If there is a CD in the drive and
mounted, the eject button should be software-locked.  Do you mean that this
does not happen for you?  ...As long as it does, a stupid workaround would
be "leave a CD in the drive mounted all the time".

--
Hank Leininger <hlein@progressive-comp.com> 
  
