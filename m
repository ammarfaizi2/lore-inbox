Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271022AbUJUWDx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271022AbUJUWDx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271019AbUJUWBs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:01:48 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:9953 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S270998AbUJUV5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:57:24 -0400
Subject: Re: Proposal: Desktop kernel bk tree/patchset.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041021214142.GA14250@kroah.com>
References: <1098344977.4146.21.camel@desktop.cunninghams>
	 <20041021161710.GA10561@kroah.com>
	 <1098393829.4146.38.camel@desktop.cunninghams>
	 <20041021214142.GA14250@kroah.com>
Content-Type: text/plain
Message-Id: <1098395480.4146.53.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 22 Oct 2004 07:51:21 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2004-10-22 at 07:41, Greg KH wrote:
> Then why stop at USB?  Why not pci, i2c and driver core bk pulls too?
> Continue down that path and you've duplicated the -mm tree :)

I was only thinking of USB because that's one of the areas at the
forefront of my mind at the moment: USB support doesn't work well with
suspending to disk yet.

That said, you're right, I should probably look at the others too. Don't
want to duplicate -mm though!

It's only a proposal :>

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.

