Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132818AbRDPAp3>; Sun, 15 Apr 2001 20:45:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132819AbRDPApT>; Sun, 15 Apr 2001 20:45:19 -0400
Received: from juicer39.bigpond.com ([139.134.6.96]:22521 "EHLO
	mailin8.bigpond.com") by vger.kernel.org with ESMTP
	id <S132818AbRDPApI>; Sun, 15 Apr 2001 20:45:08 -0400
Content-Type: text/plain; charset=US-ASCII
From: David Findlay <david_j_findlay@yahoo.com.au>
Reply-To: david_j_findlay@yahoo.com.au
Organization: Davsoft
To: "Mike A. Harris" <mharris@opensourceadvocate.org>
Subject: Re: IP Acounting Idea for 2.5
Date: Tue, 17 Apr 2001 08:46:12 +1000
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.33.0104152039130.1616-100000@asdf.capslock.lan>
In-Reply-To: <Pine.LNX.4.33.0104152039130.1616-100000@asdf.capslock.lan>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <01041708461209.00352@workshop>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 April 2001 10:40, you wrote:
> Perhaps I misunderstand what it is exactly you are trying to do,
> but I would think that this could be done entirely in userland by
> software that just adds rules for you instead of you having to do
> it manually.

I suppose, but it would be so much easier if the kernel did it automatically. 
Having a rule to go through for each IP address to be logged would be slower 
than implementing one rule that would log all of them. Doing this in the 
kernel would improve preformance.

David
