Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUEaCBu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUEaCBu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 22:01:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUEaCBu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 22:01:50 -0400
Received: from main.gmane.org ([80.91.224.249]:28374 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264500AbUEaCBt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 22:01:49 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: xfs partition refuses to mount
Date: Mon, 31 May 2004 04:02:31 +0200
Message-ID: <yw1xk6ytbbgo.fsf@kth.se>
References: <40B8D24A.4080703@xfs.org> <Pine.GSO.4.33.0405291528450.14297-100000@sweetums.bluetronic.net>
 <20040531113141.A1116544@boing.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:KNhpZOG6tXlw9HUwda74Sp2QSQE=
Cc: linux-xfs@oss.sgi.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Shimmin <tes@sgi.com> writes:

> Hi Ricky,
>
> On Sat, May 29, 2004 at 03:35:34PM -0400, Ricky Beam wrote:
>> (I've had the journal become spooge on a sparc64 box a few times.)
>> 
> Until May 20 (just over a week ago) recovery on sparc64 (and big endian
> 64) did not work. A fix went into xfs_bit.c thanks to Nicolas
> Boullis. (Our XFS qa tests are routinely run on intel cpus)

What about 64-bit little endian?  I'm using XFS on Alpha, and it seems
to be working.  Is there something I should watch out for?

-- 
Måns Rullgård
mru@kth.se

