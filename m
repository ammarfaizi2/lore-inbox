Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284925AbRLPX16>; Sun, 16 Dec 2001 18:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284927AbRLPX1w>; Sun, 16 Dec 2001 18:27:52 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:61596 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S284925AbRLPX1f>;
	Sun, 16 Dec 2001 18:27:35 -0500
Date: Sun, 16 Dec 2001 18:27:33 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Robert Love <rml@tech9.net>
cc: =?ISO-8859-1?Q?Ra=FAlN=FA=F1ez?= de Arenas Coronado 
	<raul@viadomus.com>,
        Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Is /dev/shm needed?
In-Reply-To: <1008541849.11242.2.camel@phantasy>
Message-ID: <Pine.GSO.4.21.0112161825210.937-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 16 Dec 2001, Robert Love wrote:

> have lots of memory to spare, give it a try.  Mount /tmp or all of /var
> in tmpfs.

What?  /var contains things like /var/spool/mail.  I _really_ doubt
that mailboxes disappearing after reboot will make anyone happy.

