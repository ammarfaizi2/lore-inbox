Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261852AbUDZUDg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbUDZUDg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 16:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263375AbUDZUDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 16:03:36 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:55516 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261852AbUDZUDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 16:03:35 -0400
Message-ID: <408D6B0A.5060305@nortelnetworks.com>
Date: Mon, 26 Apr 2004 16:03:22 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Load hid.o module synchronously?
References: <s5g8ygi4l3q.fsf@patl=users.sf.net>	<408D65A7.7060207@nortelnetworks.com> <s5gisfm34kq.fsf@patl=users.sf.net>
In-Reply-To: <s5gisfm34kq.fsf@patl=users.sf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick J. LoPresti wrote:

> You mean under sysfs or usbfs?  Or both?

Somewhere in there...

> I see how I can scan for a USB keyboard after loading the USB host
> controller module.  I think.  But what do I look for, exactly, to tell
> when hid.o has hooked itself up to the keyboard?

I don't know exactly what you'd look for.  Greg K-H would be the guy to ask, I think.

Chris
