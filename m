Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1163537AbWLGWxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163537AbWLGWxV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 17:53:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163556AbWLGWxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 17:53:21 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:45035 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1163537AbWLGWxU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 17:53:20 -0500
Message-ID: <45789B58.8090307@garzik.org>
Date: Thu, 07 Dec 2006 17:53:12 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Daniel Barkalow <barkalow@iabervon.org>, gregkh@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: Disable INTx when enabling MSI
References: <Pine.LNX.4.64.0612071659010.20138@iabervon.org> <Pine.LNX.4.64.0612071440480.3615@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612071440480.3615@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Thu, 7 Dec 2006, Daniel Barkalow wrote:
>> Jeff proposed a patch in http://lkml.org/lkml/2006/11/21/332 when Linus 
>> wanted to do it in the PCI layer, but nobody seems to have told the actual 
>> PCI maintainer.
> 
> I got a patch from Jeff, but it was marked as totally untested, and wasn't 
> even signed-off, so I asked for that to be fixed, and never heard back.
> 
> If somebody sends me the patch that disables INTx when MSI is enabled, 
> with testing, and saying "I verified that this fixed it for me", I will 
> happily apply it.

Making it now...

	Jeff



