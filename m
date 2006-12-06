Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937819AbWLFXza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937819AbWLFXza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 18:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937821AbWLFXz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 18:55:29 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:59798 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937819AbWLFXz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 18:55:29 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45775861.9060507@s5r6.in-berlin.de>
Date: Thu, 07 Dec 2006 00:55:13 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
CC: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <20061205184921.GA5029@martell.zuzino.mipt.ru> <4575FF08.2030100@redhat.com> <45768116.8040804@s5r6.in-berlin.de> <457743E5.4010109@redhat.com>
In-Reply-To: <457743E5.4010109@redhat.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kristian Høgsberg wrote:
> Stefan Richter wrote:
>> You have to look at the matter not only from the POV of API design but
>> also of deployment and support.
> 
> My POV here *is* about deployment and support, but from the kernel side
> of things.  If you commit yourself to long time support for the firewire
> stack, would you prefer 4 slightly different streaming drivers with
> different user space interfaces, or just one userspace driver with one
> userspace interface, that enables the 4 different types of streaming to
> be done in userspace?

My own preference certainly came across during in the recent thread on
linux1394-devel about deprecation dates... :-)

> The design of the streaming interfaces have been
> focused on enabling all these ad-hoc, in-kernel drivers to move to
> userspace, to make it feasible to actually support the stack.

-- 
Stefan Richter
-=====-=-==- ==-- --===
http://arcgraph.de/sr/
