Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261291AbREPRTz>; Wed, 16 May 2001 13:19:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262018AbREPRTp>; Wed, 16 May 2001 13:19:45 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:21421 "EHLO
	nynetops04.e-steel.com") by vger.kernel.org with ESMTP
	id <S261291AbREPRTe>; Wed, 16 May 2001 13:19:34 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
Newsgroups: e-steel.mailing-lists.linux.linux-kernel
Subject: Re: LANANA: To Pending Device Number Registrants
Date: 16 May 2001 13:19:28 -0400
Organization: e-STEEL Netops news server
Message-ID: <m366f1fbz3.fsf@shookay.e-steel.com>
In-Reply-To: <200105161702.f4GH2Cu05908@habitrail.home.fools-errant.com>
NNTP-Posting-Host: shookay.e-steel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: nynetops04.e-steel.com 990029880 21126 192.168.3.43 (16 May 2001 16:18:00 GMT)
X-Complaints-To: news@nynetops04.e-steel.com
NNTP-Posting-Date: 16 May 2001 16:18:00 GMT
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hacksaw@hacksaw.org (Hacksaw) writes:

> >So what is your solution for preventing a boot failure after disks/partitions
> >change ?
> >volume labels/UUID ?
> 
> As a sys-admin, let me add a vote for this. Having (one day) a prom monitor 
> program that looks at all the disks, and gives a menu of which one to boot 
> from would make life so nice.
> 
> I very often had to move disks from one platform to another, and changing ID's 
> on the was hard or impossible in some cases, and required in others. Being 
> able to find the disk by a label is a thousand times better.

Did you ever try grub?? This a gnu project, a boot-loader, with an embedded
shell... You can read ext2fs and select, your kernel, your root disk, your
params, etc... 
-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
