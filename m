Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270464AbUJTX5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270464AbUJTX5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 19:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270431AbUJTXzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 19:55:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:52648 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270627AbUJTXxg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:53:36 -0400
Date: Wed, 20 Oct 2004 16:16:32 -0700
From: Greg KH <greg@kroah.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
Subject: Re: usblp BKL removal
Message-ID: <20041020231632.GG15716@kroah.com>
References: <20041004172317.372bc9a9@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004172317.372bc9a9@lembas.zaitcev.lan>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 05:23:17PM -0700, Pete Zaitcev wrote:
> Hello, Vojtech,
> 
> the appended patch is not in yet, what gives? I sent it to Marcelo with
> an understanding that it would be in Linus tree any day now. It was a couple
> of months ago. It's not just BKL witchhunt either. I remember that it fixed
> an oops, although I do not remember the precise scenario by now (it had
> something to do with a race between ->release and ->disconnect).


Applied, thanks.

greg k-h
