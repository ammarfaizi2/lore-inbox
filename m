Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWDKUfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWDKUfH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 16:35:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751381AbWDKUfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 16:35:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:65187 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751281AbWDKUfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 16:35:06 -0400
Date: Tue, 11 Apr 2006 13:30:41 -0700
From: Greg KH <gregkh@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Subject: Re: several messages
Message-ID: <20060411203041.GA5555@suse.de>
References: <20060411173323.GA29965@kroah.com> <Pine.LNX.4.61.0604112102170.25940@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0604112102170.25940@yvahk01.tjqt.qr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2006 at 09:04:42PM +0200, Jan Engelhardt wrote:
> 
> >Date: Tue, 11 Apr 2006 09:26:20 -0700
> >Subject: Linux 2.6.16.3
> >David Howells:
> >      Keys: Fix oops when adding key to non-keyring [CVE-2006-1522]
> 
> >Date: Tue, 11 Apr 2006 10:33:23 -0700
> >Subject: Linux 2.6.16.4
> >Oleg Nesterov:
> >      RCU signal handling [CVE-2006-1523]
> 
> Now admins spend another hour this day just to upgrade.
> These two patches could have been queued until the end of the day. Maybe 
> another one turns up soon.

The first one went out last night, as it was a real issue that affected
people and I had already waited longer than I felt comfortable with, due
to travel issues I had (two different talks in two different cities in
two different days.)

The second one went out today, because it was reported today.  Should I
have waited until tomorrow to see if something else came up?

thanks,

greg k-h
