Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUCSWco (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 17:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263135AbUCSWco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 17:32:44 -0500
Received: from main.gmane.org ([80.91.224.249]:4527 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263134AbUCSWcm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 17:32:42 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: CDFS
Date: Fri, 19 Mar 2004 23:32:40 +0100
Message-ID: <yw1x65d05uyf.fsf@kth.se>
References: <Pine.LNX.4.44.0403191640460.3892-100000@einstein.homenet> <Pine.LNX.4.53.0403191200120.3752@chaos>
 <405B681F.3050702@stesmi.com> <Pine.LNX.4.53.0403191642590.6876@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-2480.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:hUdDkNQ1ih/n612970pse8pibrc=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" <root@chaos.analogic.com> writes:

> On Fri, 19 Mar 2004, Stefan Smietanowski wrote:
>
>> Hi.
>>
>> > Script started on Fri Mar 19 12:01:38 2004
>> > # umount /mnt
>> > # umount /mnt
>> > umount: /mnt: not mounted
>> > # umount -t iso9660 /dev/cdrom /mnt
>> ^^^^^^^^
>>
>> use "mount" instead of "umount" to mount something.
>>
>
> I did. Note that `mount` replies below. I don't know why there
> is a 'u' in the echo...

Maybe it's related to the backspace at the end of the line.

-- 
Måns Rullgård
mru@kth.se

