Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751354AbVIXAcd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbVIXAcd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 20:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751356AbVIXAcd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 20:32:33 -0400
Received: from web52613.mail.yahoo.com ([206.190.48.216]:40321 "HELO
	web52613.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751354AbVIXAcc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 20:32:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Va7Q0bGHUsnLLm585HP0Jvojp8Tx1NxVrh+tqdMfyJnsHhctf+teCCKhyJWvemvXqmKOgCtdiAZSxhyOYzEJtAc9GUW0kFe6Riog5d5GxKiV/UWC6gUWTwF0e8Cu4+1uKIttB+If5Nu+vOHmId6pRRqI2EmpV03vVSGs8QNTPmg=  ;
Message-ID: <20050924003231.44867.qmail@web52613.mail.yahoo.com>
Date: Sat, 24 Sep 2005 10:32:31 +1000 (EST)
From: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Subject: Re: [PROBLEM] USB Storage & D state processes
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20050923142927.GA13433@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Greg KH <greg@kroah.com> wrote:
> > ... 
> > Software:
> > FC4
> > 2.6.14-rc2 (vanilla)
> 
> Try 2.6.14-rc2-git2, it should be fixed there.

Yes. When I tried to mount/umount usb storage few
times, it appears to work normal under
2.6.14-rc2-git3. I'll keep an eye on usb-storage
throughout 2.6.14-rc*.
 
> thanks,

Likewise thank you.
 
Hari


Send instant messages to your online friends http://au.messenger.yahoo.com 
