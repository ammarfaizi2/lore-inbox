Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310603AbSCHAAY>; Thu, 7 Mar 2002 19:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310604AbSCHAAP>; Thu, 7 Mar 2002 19:00:15 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:46343 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S310603AbSCHAAI>;
	Thu, 7 Mar 2002 19:00:08 -0500
Date: Thu, 7 Mar 2002 20:59:47 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "Jonathan A. George" <JGeorge@greshamstorage.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel SCM: When does CVS fall down where it REALLY matters?
In-Reply-To: <3C87FD12.8060800@greshamstorage.com>
Message-ID: <Pine.LNX.4.44L.0203072057510.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Mar 2002, Jonathan A. George wrote:

> I am considering adding some enhancements to CVS to address deficiencies
> which adversely affect my productivity.

> ... I would like to know what the Bitkeeper users consider the minimum
> acceptable set of improvements that CVS would require for broader
> acceptance.

1) working merges

2) atomic checkins of entire patches, fast tags

3) graphical 2-way merging tool like bitkeeper has
   (this might not seem essential to people who have
   never used it, but it has saved me many many hours)

4) distributed repositories

5) ability to exchange changesets by email

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

