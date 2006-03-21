Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030220AbWCURvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030220AbWCURvJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 12:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWCURvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 12:51:08 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:50067 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030301AbWCURvH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 12:51:07 -0500
Message-ID: <44203D00.4030507@garzik.org>
Date: Tue, 21 Mar 2006 12:50:56 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       nfs@lists.sourceforge.net, nfsv4@linux-nfs.org
Subject: Re: [GIT] NFS client update for 2.6.16
References: <1142961077.7987.14.camel@lade.trondhjem.org>
In-Reply-To: <1142961077.7987.14.camel@lade.trondhjem.org>
Content-Type: multipart/mixed;
 boundary="------------080902020709090205040305"
X-Spam-Score: -2.4 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.4 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080902020709090205040305
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Trond Myklebust wrote:
> Hi Linus,
> 
> Please pull from the repository at
> 
>    git pull git://git.linux-nfs.org/pub/linux/nfs-2.6.git
> 
> This will update the following files through the appended changesets.

It would IMO be nice if you would pipe the changelog through 'git 
shortlog', to better summarize the submission.  And if the cumulative 
patch isn't over 100k or so, include that in the email for any last 
minute review.

I've attached the simple script I use to generate pull emails for 
Andrew/Linus...

	Jeff



--------------080902020709090205040305
Content-Type: application/x-shellscript;
 name="mkmsg.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="mkmsg.sh"

IyEvYmluL3NoCgpCUkFOQ0g9IiQxIgpURVhUX09VVD0iJDIiCgpQV0Q9YHB3ZGAKUkVQTz1g
YmFzZW5hbWUgJFBXRGAKCmVjaG8gIlBsZWFzZSBwdWxsIGZyb20gJyRCUkFOQ0gnIGJyYW5j
aCBvZiIgPiAkVEVYVF9PVVQKZWNobyAibWFzdGVyLmtlcm5lbC5vcmc6L3B1Yi9zY20vbGlu
dXgva2VybmVsL2dpdC9qZ2FyemlrLyRSRVBPLmdpdCIgXAoJPj4gJFRFWFRfT1VUCmVjaG8g
IiIgPj4gJFRFWFRfT1VUCmVjaG8gInRvIHJlY2VpdmUgdGhlIGZvbGxvd2luZyB1cGRhdGVz
OiIgPj4gJFRFWFRfT1VUCmVjaG8gIiIgPj4gJFRFWFRfT1VUCgpnaXQgZGlmZiBtYXN0ZXIu
LiRCUkFOQ0ggfCBkaWZmc3RhdCAtcDEgPj4gJFRFWFRfT1VUCmVjaG8gIiIgPj4gJFRFWFRf
T1VUCmdpdCBsb2cgLS1uby1tZXJnZXMgbWFzdGVyLi4kQlJBTkNIIHwgZ2l0IHNob3J0bG9n
ID4+ICRURVhUX09VVApnaXQgZGlmZiBtYXN0ZXIuLiRCUkFOQ0ggPj4gJFRFWFRfT1VUCgo=
--------------080902020709090205040305--
