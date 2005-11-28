Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbVK1CBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbVK1CBO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Nov 2005 21:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbVK1CBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Nov 2005 21:01:14 -0500
Received: from zproxy.gmail.com ([64.233.162.205]:13502 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751219AbVK1CBO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Nov 2005 21:01:14 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hjGVG++pP2sqq64QSA3vHx4MrIXF4wWfFbAt0FYhMt7p+l01qlRO7jTJ6j3IAbskX2Gg8FJZSLln0tKw0KsZc2Nrt7xbcgL/AdC59PTqn/b95emxf4rC5MwwOiIXkFDymbeL1I0yVdnHRMrd7sJK5Ttkleu8CthnLdraQImRNFE=
From: Patrick McFarland <diablod3@gmail.com>
To: Mark Knecht <markknecht@gmail.com>
Subject: Re: umount
Date: Sun, 27 Nov 2005 21:01:07 -0500
User-Agent: KMail/1.9
Cc: gcoady@gmail.com, Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
References: <200511272154.jARLsBb11446@apps.cwi.nl> <jdkko1hs90ffvqru9v354vrubggcdrnhhj@4ax.com> <5bdc1c8b0511271742y75306962h67193b8a0191841d@mail.gmail.com>
In-Reply-To: <5bdc1c8b0511271742y75306962h67193b8a0191841d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511272101.07771.diablod3@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 27 November 2005 20:42, Mark Knecht wrote:
> On 11/27/05, Grant Coady <grant_lkml@dodo.com.au> wrote:
> > It leaves me with a little distrust of linux' handling of non-locked
> > removable media (as opposed to lockable media like a zipdisk or cdrom).
> >
> > Grant.
>
> Under Windows, if a 1394 drive is unplugged without unmounting, it you
> get a pop up dialog on screen telling you that data may be lost, etc.
> while under any of the main environments I've tried under Linux
> (Gnome, KDE, fluxbox) there are no such messages to the user. I have
> not investigated log files very deeply, other than to say that dmesg
> will show the drive going away but doesn't say it was a problem.
>
> I realize it's probably 100x more difficult to do this under Linux, at
> least at the gui level, but I agree with your main point that my trust
> factor is just a bit lower here.

No, WIndows says that because it is unable to mount a partition as sync, 
unlike Linux. Linux Desktop Environments simply don't tell the user because 
no data is lost if they unplug the media.

-- 
Patrick "Diablo-D3" McFarland || diablod3@gmail.com
"Computer games don't affect kids; I mean if Pac-Man affected us as kids,
we'd all be running around in darkened rooms, munching magic pills and
listening to repetitive electronic music." -- Kristian Wilson, Nintendo,
Inc, 1989

