Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264293AbRFSPOj>; Tue, 19 Jun 2001 11:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264298AbRFSPO3>; Tue, 19 Jun 2001 11:14:29 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:59148
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S264293AbRFSPOM>; Tue, 19 Jun 2001 11:14:12 -0400
Date: Tue, 19 Jun 2001 11:13:47 -0400
From: Chris Mason <mason@suse.com>
To: Alan Cox <alan@redhat.com>, Justin Guyett <justin@soze.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.6-pre3 breaks ReiserFS mount on boot
Message-ID: <46700000.992963627@tiny>
In-Reply-To: <E15CHtN-0005gC-00@the-village.bc.nu>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tuesday, June 19, 2001 10:33:49 AM +0100 Alan Cox
<alan@lxorguk.ukuu.org.uk> wrote:

>> 
>> This after only using ac15 for a few hours... I've never seen anything
>> like that with ac13, which I've used for days.
> 
> Is ac14 stable for you ?
> 

Hi Justin,

ac14 was the first with a big reiserfs cleanup patch from me, so it would
be great if you could try it to help narrow things down a bit.

I can also just send you the patch to reverse, it might be faster, just let
me know which way you'd prefer.

-chris

