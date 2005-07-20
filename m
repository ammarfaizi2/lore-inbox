Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVGTA0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVGTA0w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 20:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbVGTA0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 20:26:51 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:877 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261749AbVGTA0G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 20:26:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=doOUPxrjWF2aw+wgxOf7M9F5qbxWVqNctWozZ6GyE/UJnl91WL26TmAb5gKaw0N/j4zV0LutCuVH1y1aAAujNytF+fW5sNX7t0i+Sl8OFEHe4tLV5LsY1wYo4WKjcVjG47xEk8W5Vr2R0ejEKbS1jSS6hfmP+FLFPp5HJReQV+s=
Message-ID: <9a87484905071917256e3b71cf@mail.gmail.com>
Date: Wed, 20 Jul 2005 02:25:41 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: omb@bluewin.ch
Subject: Re: how to be (SAFE) a kernel developer ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42DD7644.5040304@khandalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a3ed56505071807357fc419e7@mail.gmail.com>
	 <9a87484905071818116f7cb0de@mail.gmail.com>
	 <42DD7644.5040304@khandalf.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/05, Brian O'Mahoney <omb@khandalf.com> wrote:
> 
> To:	unlisted-recipients:; (no To-header on input) 
            ^^^
             That's a bad habbit - makes it impossible to send a
proper reply back to all the recipients. LKML is a public list, please
use To: and CC: so it's possible to reply to the proper people, and
don't trim the CC: list please.


> Jesper Juhl wrote: ...
> 
> much useful advice, almost all of which I agree with _BUT_
> 
> please do NOT debug kernel mods on your 'main-box', where your
> filesystems live. unless you like to live dangerously and make
> perfect backups you don't mind spending lots of hours restoring,
> 
You are right. A sacrificial box or at least proper backups of any
important stuff is important. I didn't write that since I figured it
to be obvious, but I guess I should have spelled it out anyway. Thank
you for making that bit clear :-)


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
