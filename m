Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129377AbRBPMEo>; Fri, 16 Feb 2001 07:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129527AbRBPMEd>; Fri, 16 Feb 2001 07:04:33 -0500
Received: from highland.isltd.insignia.com ([195.217.222.20]:1296 "EHLO
	highland.isltd.insignia.com") by vger.kernel.org with ESMTP
	id <S129377AbRBPMEV>; Fri, 16 Feb 2001 07:04:21 -0500
Message-ID: <3A8D177C.2A45051C@insignia.com>
Date: Fri, 16 Feb 2001 12:05:16 +0000
From: Stephen Thomas <stephen.thomas@insignia.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.1-ac15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Tulip in 2.4.1-ac14 still poorly
In-Reply-To: <3A8D0C92.7060AABE@insignia.com> <3A8D1338.27F9EFDF@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> Could you try the attached oneliner patches?
> 
> patch-tulip-fix1 is integrated in -ac15, and I send patch-tulip-typo to
> Alan a few seconds ago.

Just booted ac15 with the typo patch applied, seems to work well enough
for me to be sending you this and there are no obvious nasty messages in
my syslog.  Thanks!

Stephen
