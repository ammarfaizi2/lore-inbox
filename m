Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271156AbTGPWAM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271152AbTGPV6A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 17:58:00 -0400
Received: from mail.kroah.org ([65.200.24.183]:11240 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S271146AbTGPV5E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 17:57:04 -0400
Date: Wed, 16 Jul 2003 15:11:54 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: what's left for 64 bit dev_t
Message-ID: <20030716221154.GA3051@kroah.com>
References: <20030716184609.GA1913@kroah.com> <20030716130915.035a13ca.akpm@osdl.org> <20030716210253.GD2279@kroah.com> <20030716141320.5bd2a8b3.akpm@osdl.org> <20030716213607.GA2773@kroah.com> <20030716150010.6ba8416f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716150010.6ba8416f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 03:00:10PM -0700, Andrew Morton wrote:
> Greg KH <greg@kroah.com> wrote:
> >
> > Who else prints out the dev_t value?
> 
> There are only a few places where it happens.  It is random junk like
> "mounted filesystem foo on device %d"

Ah.

Ok, to change the topic a bit, what's left to do on the 64bit dev_t
stuff?  I know your tree has some support, but there was rumors that
more was really needed to finish this off right.

Any ideas?  Thoughts?  Patches?  :)

thanks,

greg k-h
