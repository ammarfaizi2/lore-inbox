Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbTHYL5V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 07:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbTHYL5V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 07:57:21 -0400
Received: from main.gmane.org ([80.91.224.249]:3217 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261238AbTHYL5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 07:57:20 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: DMA timeouts on SIS IDE
Date: Mon, 25 Aug 2003 13:57:18 +0200
Message-ID: <yw1xfzjqar1d.fsf@users.sourceforge.net>
References: <3F281C06.70707@inet6.fr> <yw1xbrvbgdx5.fsf@users.sourceforge.net>
 <yw1xptjhs9bj.fsf@users.sourceforge.net>
 <yw1xsmnqas8q.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:aCBgzf4W3Qt2PbBIec7+7Wb+9Y8=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@users.sourceforge.net (Måns Rullgård) writes:

>> I noticed that sometimes I also get this in the kernel log:
>>
>> hda: dma_timer_expiry: dma status == 0x21
>> hda: DMA timeout error
>> hda: dma timeout error: status=0xd0 { Busy }
>>
>> hda: DMA disabled
>> ide0: reset: success
>> Loosing too many ticks!
>> TSC cannot be used as a timesource. (Are you running with SpeedStep?)
>> Falling back to a sane timesource.
>
> This appears to have been fixed in 2.6.0-test4.

I'm afraid I was wrong.  It happened again.

-- 
Måns Rullgård
mru@users.sf.net

