Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130240AbRB1QNV>; Wed, 28 Feb 2001 11:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130241AbRB1QNL>; Wed, 28 Feb 2001 11:13:11 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:11937 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130240AbRB1QNI>;
	Wed, 28 Feb 2001 11:13:08 -0500
Message-ID: <3A9D238C.B5761423@mandrakesoft.com>
Date: Wed, 28 Feb 2001 11:13:00 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Knernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Phillip Ezolt <ezolt@perf.zko.dec.com>, alan@redhat.com,
        William Carr <wcarr@perf.zko.dec.com>
Subject: Re: Tulip 2-card problem with 2.4.2-ac5
In-Reply-To: <Pine.OSF.4.33.0102280950430.103975-100000@perf.zko.dec.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the tulip in the 'ac' patchkit includes some bad changes
for 2104x-based cards.  Fix in the works...

NetGear/PNIC owners:  let me know if 2.4.2-ac6 doesn't fix your
problems.

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
