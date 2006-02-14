Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161067AbWBNPAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbWBNPAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 10:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161066AbWBNPAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 10:00:46 -0500
Received: from webbox4.loswebos.de ([213.187.93.205]:24524 "EHLO
	webbox4.loswebos.de") by vger.kernel.org with ESMTP
	id S1161067AbWBNPAp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 10:00:45 -0500
Date: Tue, 14 Feb 2006 16:00:52 +0100
From: Marc Koschewski <marc@osknowledge.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: sfrench@samba.org, linux-cifs-client@lists.samba.org,
       samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc: CIFS reproducibly freezes the computer
Message-ID: <20060214150052.GB5905@stiffy.osknowledge.org>
References: <20060214135016.GC10701@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060214135016.GC10701@stusta.de>
X-PGP-Fingerprint: D514 7DC1 B5F5 8989 083E  38C9 5ECF E5BD 3430 ABF5
X-PGP-Key: http://www.osknowledge.org/~marc/pubkey.asc
X-Operating-System: Linux stiffy 2.6.16-rc3-marc-g108dff7d-dirty
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Adrian Bunk <bunk@stusta.de> [2006-02-14 14:50:16 +0100]:

> Hi Steve,
> 
> I do obvserve the following on my i386 computer:
> 
> I'm connecting to a Samba server.
> 
> Copying data to the server works without any problems.
> 
> When trying to copy some GB from the server, my computer completely 
> frezzes after some 100 MB. This is reproducible.
> 
> "Complete freeze" is:
> - no reaction to any input, even when I was in the console the magic 
>   SysRq key is not working
> - if XMMS was playing, the approx. half a second of the song that was
>   playing at the time when it happened is played in an endless loop by
>   the sound chip
> 

Adrian,

	I just copied some ~2 GB file and my system is running OK. The share is
a CIFS on a Samba-Server of MacOS X.

Marc
