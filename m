Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272299AbRIEUS2>; Wed, 5 Sep 2001 16:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272304AbRIEUSS>; Wed, 5 Sep 2001 16:18:18 -0400
Received: from mailout06.sul.t-online.com ([194.25.134.19]:63748 "EHLO
	mailout06.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S272299AbRIEUSK>; Wed, 5 Sep 2001 16:18:10 -0400
Message-ID: <3B96884C.D773F4B8@t-online.de>
Date: Wed, 05 Sep 2001 22:17:16 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: joe.mathewson@btinternet.com
CC: linux-kernel@vger.kernel.org
Subject: Re: [OFFTOPIC] Secure network fileserving Linux <-> Linux
In-Reply-To: <200109051913.f85JD2K01304@ambassador.mathewson.int>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joseph Mathewson schrieb:
> 
> Sorry to ask another annoying question so quickly after my SCSI problems,
> but
> 
> Does anyone know of/use a secure network filesharing system on a Linux
> network?  We currently have a room of about 10 machines, mostly Linux
> clients (some MacOS X, soon to come Sun and HP-UX boxes) and servers (all
> running Linux).
> 
> For some time now, we've been using NFS for filesharing /home and have been
> extremely concerned about security.  All the clients in theory run the same
> uids/gids, thanks to LDAP, but that doesn't stop someone plugging in an
> unauthorized machine and merrily destroying everyone's home directories.
> 
> Apparently some work was done to Kerberize various bits of NFS, and Sun
> have a secure(r) implementation in Solaris.
> 
> Does anyone know of a free (preferably easy :) way of secure Linux <->
> Linux filesharing?  Apologies if that seems like a flame, maybe I've missed
> the obvious solution.  (Preferably a solution that doesn't involve editing
> /etc/exports to only allow connections from specified IPs, because if
> someone was going to go to the length of destroying our data, they could
> fake that.  Similarly, MAC addresses.)

Hello...

What about switching to IPSec ?

Should work between Linuxboxes....or why shouldn't it ?

Solong...
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
