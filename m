Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269315AbUJQW6R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269315AbUJQW6R (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 18:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269316AbUJQW6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 18:58:16 -0400
Received: from mail.kroah.org ([69.55.234.183]:1223 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269315AbUJQW6P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 18:58:15 -0400
Date: Sun, 17 Oct 2004 15:57:33 -0700
From: Greg KH <greg@kroah.com>
To: Alexandre Oliva <aoliva@redhat.com>
Cc: linux-kernel@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: forcing PS/2 USB emulation off
Message-ID: <20041017225733.GA25435@kroah.com>
References: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <orzn2lyw8k.fsf@livre.redhat.lsd.ic.unicamp.br>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 04:34:35PM -0300, Alexandre Oliva wrote:
> 
> Here's Vojtech's patch, updated to 2.6.9-rc4-bk2-ish (Fedora Core
> kernel-2.6.8-1.624).  Is there a good reason to keep it out of the
> base kernel?

It's already in the -mm kernels, and will be sent to Linus after 2.6.9
is out.  If you could test that kernel and verify that it works for this
situation, I would appreciate it.

thanks,

greg k-h
