Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266077AbUBCQRh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 11:17:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266074AbUBCQRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 11:17:37 -0500
Received: from main.gmane.org ([80.91.224.249]:46758 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266077AbUBCQRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 11:17:35 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: 2.6.0, cdrom still showing directories after being erased
Date: Tue, 03 Feb 2004 17:17:33 +0100
Message-ID: <yw1xsmhsf882.fsf@kth.se>
References: <20040203131837.GF3967@aurora.fi.muni.cz> <Pine.LNX.4.53.0402030839380.31203@chaos>
 <401FB78A.5010902@zvala.cz> <Pine.LNX.4.53.0402031018170.31411@chaos>
 <200402031602.i13G2NFi002400@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 213-187-164-3.dd.nextgentel.com
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:YNYGvq0p3PzvviaVtl/tO7yxNPQ=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford <john@grabjohn.com> writes:

>> That's not what he said and, I assure you that if he unmounted
>> it there would not be any buffers to flush. Execute `man umount`.
>
> I think the original poster was referring to the cache on the device.
>
> I.E.
>
> mount disc
> view contents
> unmount disc
> erase disc - but don't erase the CD-R drive's cache of the media
> mount disc
> view old contents of the media from the CD-R drive's cache

If that's the case, the drive is broken.  We can't help that.

-- 
Måns Rullgård
mru@kth.se

