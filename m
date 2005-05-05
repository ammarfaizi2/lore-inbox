Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262010AbVEEDOB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262010AbVEEDOB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 23:14:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVEEDOB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 23:14:01 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:64718 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262010AbVEEDN5 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 23:13:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GnccoLOOrM3XgpUZR4OPjrfOriLjgzDoAfK9arTYuO6dfHnMQo+1xtYZgtW4IwSc6Wg5bwS/o99gGFUNEQ7uNmAW67rPeZlKGOuLPxPF3KX0urUh6KxhyNhXYsjd8VOTufQyfY+NuKCcYODbunfT8ZTJgLabXufp4/TWrQoqfNw=
Message-ID: <d4757e6005050420133ecd39c6@mail.gmail.com>
Date: Wed, 4 May 2005 23:13:55 -0400
From: Joe <joecool1029@gmail.com>
Reply-To: Joe <joecool1029@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Extremely poor umass transfer rates
In-Reply-To: <4273E5B3.6040708@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3YjKy-72a-21@gated-at.bofh.it> <3YkGD-7NT-15@gated-at.bofh.it>
	 <3Ylt2-8mA-7@gated-at.bofh.it> <3YlWb-px-35@gated-at.bofh.it>
	 <3YCkl-5lB-21@gated-at.bofh.it> <4273E5B3.6040708@shaw.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Something is definetly going on with either vfat or the USB drivers...
My ipod is unrunnable on linux now.  To put it plainly, it transfers
painfully slow (on USB 2.0 mind you), it randomly ceases to respond
during file transfers.. and will only respond if replugged in.. its
corrupted my music and the fs to the point where i've now done two
low-level formats, and every time i put the stuff back on, the same
problems persist.

Oh yeah, my CF cards do the same thing.. you'll be transferring some
files.. and then it just stops responding.  I've tested it on my USB
1.1 ports and my USB 2.0 card, also with two completley different
cardreaders.

Its just bad.. my current kernel is 2.6.12-rc3-mm2, but i've seen
these problems for awile now.. its just with this release, its much
worse.

Joe
