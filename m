Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261713AbSJUV22>; Mon, 21 Oct 2002 17:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261706AbSJUV21>; Mon, 21 Oct 2002 17:28:27 -0400
Received: from mx15.sac.fedex.com ([199.81.197.54]:39696 "EHLO
	mx15.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S261710AbSJUV2Y>; Mon, 21 Oct 2002 17:28:24 -0400
Date: Tue, 22 Oct 2002 05:33:01 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Danny ter Haar <dth@ncc1701.cistron.net>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.44 console keyboard dead
In-Reply-To: <ap1q4m$dko$1@ncc1701.cistron.net>
Message-ID: <Pine.LNX.4.44.0210220530370.23048-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/22/2002
 05:34:26 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 10/22/2002
 05:34:28 AM,
	Serialize complete at 10/22/2002 05:34:28 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2002, Danny ter Haar wrote:

> In article <Pine.LNX.4.44.0210220434280.23048-100000@boston.corp.fedex.com>,
> Jeff Chua  <jchua@fedex.com> wrote:
> >I can't type anything on the console keyboard on 2.5.44
> >rlogin works ok.
>
> Please check the settings of serial support.
> Only then you get the choice of different keyboard support
> at the next question (enable at keyboard)
>
> Got fooled by it too ;)

Guess I got fooled. Worse than that, I was using an older .config file
from 2.4 and somehow I simple don't get the menu item for AT keyboard.
I was able to configure AT keykoard only after removing .config and
rerun menuconfig again.

Thanks for the pointer,

Jeff.


