Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275480AbRIZSyw>; Wed, 26 Sep 2001 14:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275482AbRIZSyr>; Wed, 26 Sep 2001 14:54:47 -0400
Received: from [208.129.208.52] ([208.129.208.52]:60426 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S275480AbRIZSx4>;
	Wed, 26 Sep 2001 14:53:56 -0400
Message-ID: <XFMail.20010926115816.davidel@xmailserver.org>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <200109261848.f8QIm1q09567@vindaloo.ras.ucalgary.ca>
Date: Wed, 26 Sep 2001 11:58:16 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Subject: Re: Locking comment on shrink_caches()
Cc: linux-kernel@vger.kernel.org, Benjamin LaHaise <bcrl@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26-Sep-2001 Richard Gooch wrote:
> Benjamin LaHaise writes:
>> On Wed, Sep 26, 2001 at 11:43:25AM -0600, Richard Gooch wrote:
>> > BTW: your code had horrible control-M's on each line. So the compiler
>> > choked (with a less-than-helpful error message). Of course, cat t.c
>> > showed nothing amiss. Fortunately emacs doesn't hide information.
>> 
>> You must be using some kind of broken MUA -- neither mutt nor pine 
>> resulted in anything with a trace of 0x0d in it.
> 
> My MUA doesn't know about MIME at all (part of the reason I hate
> MIME). I save the message to a file and run uudeview 0.5pl13.

Maybe the file you save is in RFC format ( \r\n ) and uudeview does not trim it.



- Davide

