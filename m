Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262641AbRE3Hlv>; Wed, 30 May 2001 03:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262648AbRE3Hll>; Wed, 30 May 2001 03:41:41 -0400
Received: from highland.isltd.insignia.com ([195.217.222.20]:36880 "EHLO
	highland.isltd.insignia.com") by vger.kernel.org with ESMTP
	id <S262641AbRE3Hl2>; Wed, 30 May 2001 03:41:28 -0400
Message-ID: <3B14A47F.773FE427@insignia.com>
Date: Wed, 30 May 2001 08:42:55 +0100
From: Stephen Thomas <stephen.thomas@insignia.com>
Organization: Insignia Solutions
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: Reproducible oops when loading ns558.o in 2.4.5-ac4
In-Reply-To: <3B141DCD.C2CE9BCD@insignia.com> <20010530073340.B375@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> Just one question: How to reproduce it? Just by loading the module?

Yes, 'modprobe ns558' generates the oops.  Thereafter, lsmod
reports that ns558 is initializing.

Stephen
