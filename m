Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266507AbUHIMB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266507AbUHIMB5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266500AbUHIMB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:01:57 -0400
Received: from main.gmane.org ([80.91.224.249]:8335 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266507AbUHIMBW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:01:22 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Mon, 09 Aug 2004 14:01:16 +0200
Message-ID: <yw1xhdrc4j1v.fsf@kth.se>
References: <200408091013.i79ADQK0008995@burner.fokus.fraunhofer.de> <20040809102146.GY10418@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:868JW5gUsKNF6jzsmvdEl7NFOnE=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

>> You should learn what "make sense" means, Linux-2.6 is a clear move
>> away from the demands of a Linux user who likes to write CDs/DVDs.
>
> It's a move away from your silly idea of what users want. It's a move in
> the right direction.

I'll second that.  In fact, burning CDs, with the infamous cdrecord,
works better than ever with Linux 2.6.  And, yes, I'm using
dev=/dev/cdrom or similar.  Thanks for the silly warning btw, it makes
for a good laugh every time I need to burn a CD.

-- 
Måns Rullgård
mru@kth.se

