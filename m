Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268169AbUJDO1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268169AbUJDO1x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 10:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268168AbUJDO1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 10:27:52 -0400
Received: from open.hands.com ([195.224.53.39]:31403 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S268169AbUJDO1S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 10:27:18 -0400
Date: Mon, 4 Oct 2004 15:38:24 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bug] 2.6.8: CDROM_SEND_PACKET ioctls failing as non-root on ide scsi drives
Message-ID: <20041004143824.GH20930@lkcl.net>
References: <20041004130941.GE19341@lkcl.net> <20041004125937.GQ2287@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004125937.GQ2287@suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2004 at 02:59:37PM +0200, Jens Axboe wrote:
> On Mon, Oct 04 2004, Luke Kenneth Casson Leighton wrote:
> > kernel 2.6.8.  ioctl ("/dev/hdc", CDROM_SEND_PACKET, cmd)
> 
> please search the archives, this has been discussed extensively over the
> last month. frankly, I don't know how you were even able to miss it :)
 
 by not subscribing to the list, and searching for things as-and-when.
 ... i _did_ do a google search first, though, i promise!

 "linux kernel cdrom ioctl CDROM_SEND_PACKET" gave this:

	 http://www.cs.helsinki.fi/linux/linux-kernel/2003-13/0617.html

 which isn't exactly this month...

 l.

