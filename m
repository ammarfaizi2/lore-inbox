Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264916AbUFRB3U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUFRB3U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 21:29:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264915AbUFRB3U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 21:29:20 -0400
Received: from imo-d02.mx.aol.com ([205.188.157.34]:53391 "EHLO
	imo-d02.mx.aol.com") by vger.kernel.org with ESMTP id S264916AbUFRB3S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 21:29:18 -0400
Message-ID: <40D24564.8040307@netscape.net>
Date: Thu, 17 Jun 2004 21:29:08 -0400
From: "Nicholas S. Wourms" <nwourms@netscape.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 MultiZilla/1.6.4.0b
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Stop the Linux kernel madness
References: <40D232AD.4020708@opensound.com> <20040617173953.39eae56c.akpm@osdl.org>
In-Reply-To: <20040617173953.39eae56c.akpm@osdl.org>
X-Enigmail-Version: 0.76.8.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AOL-IP: 130.127.121.131
X-Mailer: Unknown (No Version)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> b) They shipped the kitchen sink with 2.4 and their customers still want
>    to wash the dishes in 2.6.

Heh, very funny.  Seriously, though, one "kitchen sink" feature that 
they had been shipping in 2.4 was iBCS.  Given the recent revival in 
UFS1/2 FS support, it really would be "nice to see" the iBCS binary 
compatibility code revived and merged into 2.6.  I'm sure that people in 
the scientific community would really appreciate this since there are 
still many new and legacy apps which were/are only for solaris/x86 
and/or sco/x86.

I know I'm sure to invite flames for this one, but serious thought 
should be given to re-merging the khttpd using Ingo Molnar's tux code. 
The khttpd been part of the kernel for such a long time and since it now 
works in 2.6 again, why not re-instate it?  FWICT, it is "fairly" 
self-contained, so the overall impact on existing code should be minimal.

Cheers,
Nicholas

