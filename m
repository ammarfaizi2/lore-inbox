Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbULVFeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbULVFeQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 00:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbULVFeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 00:34:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3246 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261406AbULVFeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 00:34:14 -0500
Message-ID: <41C9074E.8050406@pobox.com>
Date: Wed, 22 Dec 2004 00:34:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-usb-devel@lists.sourcefoge.net.kroah.org,
       linux-kernel@vger.kernel.org, laforge@gnumonks.org
Subject: Re: My vision of usbmon
References: <20041219230454.5b7f83e3@lembas.zaitcev.lan> <20041222005726.GA13317@kroah.com> <1103679534.5055.2.camel@npiggin-nld.site> <20041222050424.GB31076@kroah.com>
In-Reply-To: <20041222050424.GB31076@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Dec 22, 2004 at 12:38:54PM +1100, Nick Piggin wrote:
>>Is there any reason why these debug filesystems are going under the
>>root directory? Why not /sys/debug or /sys/kernel/debug or something?
> 
> 
> See the previous thread as to where to mount debugfs.  In short, I don't
> really care :)


Well, somebody should pick a single location, and try to use that 
consistently.  Sure the sysadmin can change it, but a "preferred 
default" is always nice.

	Jeff


