Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWGLJoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWGLJoZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 05:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751079AbWGLJoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 05:44:24 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:20515 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751063AbWGLJoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 05:44:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:sender;
        b=AbMwNlyxD/QxIBlhtphci+1GFefS9EWQjll9gVFjxIEo8/KOXI3nafJW5vY0r6XUu9RD5qzSIMBpIpXQupuFcwmXL51UenkO/ZB8rC026m5tOYNztu2R8mh9UHR8y/aonB+TYV5o2omCQF7D+y2cmPGMET3wsedOtYdPWmWALzk=
Date: Wed, 12 Jul 2006 11:44:16 +0200
From: Frederik Deweerdt <deweerdt@free.fr>
To: Alex Riesen <fork0@users.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Mauro Carvalho Chehab <mchehab@infradead.org>,
       v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com
Subject: Re: oops in bttv
Message-ID: <20060712094416.GA1204@slug>
References: <20060711204940.GA11497@steel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711204940.GA11497@steel.home>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 10:49:40PM +0200, Alex Riesen wrote:
> What I did was to call settings of the flashplayer and press on the
> webcam symbol there. The system didn't crash, just this oops:
> 
> BUG: unable to handle kernel NULL pointer dereference at virtual address 0000006
> 5
Does this happen every time you modprobe bttv ?

Regards,
Frederik
