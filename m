Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVBNS1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVBNS1V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 13:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVBNS1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 13:27:21 -0500
Received: from web26504.mail.ukl.yahoo.com ([217.146.176.41]:47783 "HELO
	web26504.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261513AbVBNS1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 13:27:17 -0500
Message-ID: <20050214182716.20902.qmail@web26504.mail.ukl.yahoo.com>
Date: Mon, 14 Feb 2005 18:27:16 +0000 (GMT)
From: Neil Conway <nconway_kernel@yahoo.co.uk>
Subject: Re: NFS (ext3/VFS?) bug in 2.6.8/10
To: Markus Plail <linux-kernel@gitteundmarkus.de>,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Markus Plail <linux-kernel@gitteundmarkus.de> wrote: 
> I can't help you, but just want to say that I also see those errors
> on a local xfs file system, so it doesn't seem to be a NFS problem
> I was first seeing this with 2.6.11-rc3-mm1 on a directory with 8k.

Hmm, I played about a bit with XFS, but couldn't get my particular
recipe to generate any errors whatsoever (either local or with NFS).

Can you elaborate?  Do you have a simple method which reproduces it?

Regards,
Neil

PS: I have half an idea that the problem might be to do with the
dcache.  This is probably a wild shot in the dark though as it would be
difficult to find someone who knows less than me about the whole VFS
;-))

PPS: sorry for lack of direct reply - had to manually cut and paste
your message in from an archive, as I forgot to mention in my original
post that I'm off-list at the moment.


	
	
		
___________________________________________________________ 
ALL-NEW Yahoo! Messenger - all new features - even more fun! http://uk.messenger.yahoo.com
