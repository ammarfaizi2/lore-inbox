Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262797AbTEGDJz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 23:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbTEGDJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 23:09:55 -0400
Received: from oceanic.wsisiz.edu.pl ([213.135.44.33]:2859 "EHLO
	oceanic.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S262797AbTEGDJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 23:09:54 -0400
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: Aic7xxx and Aic79xx Driver Updates
In-Reply-To: <2274070000.1051897888@aslan.btc.adaptec.com>
X-Newsgroups: wsisiz.linux-kernel
X-PGP-Key-Fingerprint: E233 4EB2 BC46 44A7 C5FC  14C7 54ED 2FE8 FEB9 8835
X-Key-ID: 829B1533
User-Agent: tin/1.5.17-20030407 ("Peephole") (UNIX) (Linux/2.4.21-pre6 (i686))
Message-Id: <20030507032226.4AEC833266E@oceanic.wsisiz.edu.pl>
Date: Wed,  7 May 2003 05:22:26 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <2274070000.1051897888@aslan.btc.adaptec.com> you wrote:
>> I thought it was an sr problem, but it doesn't seem to show up on
>> anything other than adaptec controllers?  Thanks.
> 
> I've just updated the bug.

Have You updated it on page too?
Drivers taken from http://people.freebsd.org/~gibbs/linux/SRC/

Adaptec AIC79xx driver version: 1.3.8
Adaptec AIC7902 Ultra320 SCSI adapter
aic7902: Ultra320 Wide Channel A, SCSI Id=7, PCI-X 67-100Mhz, 512 SCBs

During running slocate/updatedb:

bash-2.05b$ uptime
05:07:28  up 1 day,  8:09,  4 users,  load average: 67.07, 30.93, 12.51
                                                    ^^^^^^^^^^^^^^^^^^^

-- 
*[ £ukasz Tr±biñski ]*
