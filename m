Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751457AbWAKOsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751457AbWAKOsc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 09:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751480AbWAKOsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 09:48:32 -0500
Received: from mail.asc.de ([82.100.219.35]:56526 "EHLO mail.asc.de")
	by vger.kernel.org with ESMTP id S1751457AbWAKOsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 09:48:31 -0500
Message-ID: <43C51ABD.4050204@asc.de>
Date: Wed, 11 Jan 2006 15:48:29 +0100
From: Reinhold Jordan <r.jordan@asc.de>
Organization: ASC
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: de-de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: option memmap
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jan 2006 14:48:30.0409 (UTC) FILETIME=[16859B90:01C616BE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

is there any documentation for this option better than this in
linux/Documentation/kernel-parameters.txt ?

I have a laptop with a defect memory soldered on the main-board.
128KB of 128MB are defect started at 7936KB

As I read from kernel-parameters.txt the option
memmap=128K$7936K
reserve this area. But this seems to be simply ignored. Even, if I
fade out 64MB, Knoppix still create a RAM disk, which is larger
as the remaining memory...

Does someone know advice?

Thanks, regards, Reinhold

-- 

                         Reinhold Jordan
WWW: http://reinhold.bachrain.de          Mail: reinhold@bachrain.de
qmail-spam-protection with intelligent-greylisting, reverse-smtp....
qmail.spamfilter.051215.076.tar.bz2 actual rejects 99.995% of spam!!
