Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312364AbSDNQNp>; Sun, 14 Apr 2002 12:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312370AbSDNQNo>; Sun, 14 Apr 2002 12:13:44 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:9738 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S312364AbSDNQNo>;
	Sun, 14 Apr 2002 12:13:44 -0400
Date: Sun, 14 Apr 2002 08:13:25 -0700
From: Greg KH <greg@kroah.com>
To: Dylan Griffiths <dylang+kernel@thock.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Sandisk USB CF reader and 2.4.18; usb-storage bug?
Message-ID: <20020414151325.GB17826@kroah.com>
In-Reply-To: <3CB951D7.7090107@thock.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 17 Mar 2002 12:39:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2002 at 03:54:31AM -0600, Dylan Griffiths wrote:
> Two problems here.  The first is that even after poking in SCSI's core, 
> modprobing usb-storage hangs and is unkillable:

<snip>

Try sending this to the usb-storage maintainer, he should be able to
help you out.

thanks,

greg k-h
