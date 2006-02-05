Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbWBED6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbWBED6k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Feb 2006 22:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932599AbWBED6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Feb 2006 22:58:40 -0500
Received: from CPE-24-31-249-53.kc.res.rr.com ([24.31.249.53]:13264 "EHLO
	tsurukikun.utopios.org") by vger.kernel.org with ESMTP
	id S932598AbWBED6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Feb 2006 22:58:40 -0500
From: Luke-Jr <luke@dashjr.org>
To: "Christopher Friesen" <cfriesen@nortel.com>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
Date: Sun, 5 Feb 2006 03:58:47 +0000
User-Agent: KMail/1.9
Cc: Lee Revell <rlrevell@joe-job.com>,
       Ian Kester-Haney <ikesterhaney@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.40.0601280826160.29965-100000@jehova.dsm.dk> <1138906199.15691.54.camel@mindpipe> <43E25976.6090109@nortel.com>
In-Reply-To: <43E25976.6090109@nortel.com>
Public-GPG-Key: 0xD53E9583
Public-GPG-Key-URI: http://dashjr.org/~luke-jr/myself/Luke-Jr.pgp
IM-Address: luke-jr@jabber.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602050358.49454.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 February 2006 19:11, Christopher Friesen wrote:
> Lee Revell wrote:
> > What nvidia is doing is already illegal under the GPLv2.
>
> I don't think that's been legally proven.
>
> The question is whether it is a derivative work. 

The LGPL deals with only derivative works. The GPL also deals with mere 
*linking*. If glibc were GPL'd, it would be illegal to make an OS based on it 
with a single C program incompatible with the GPL.

> If they ship the binary blob as well as code that interfaces the binary
> blob with the kernel, and the end-user compiles the code together and
> loads it into the kernel, does that necessarily violate the GPL?

The 'code that interfaces the binary blob with the kernel' would then be 
illegal, because the code cannot be both GPL and proprietary. If the code is 
GPL and acceptable for kernel-linking, then under the terms of the GPL, the 
code cannot link to a GPL-incompatible binary blob.
