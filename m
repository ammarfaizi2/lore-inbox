Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263700AbUCUS66 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 13:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263701AbUCUS66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 13:58:58 -0500
Received: from main.gmane.org ([80.91.224.249]:5573 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263700AbUCUS65 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 13:58:57 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: ATARAID/FakeRAID/HPTRAID/PDCRAID as dm targets?
Date: Sun, 21 Mar 2004 19:58:46 +0100
Message-ID: <yw1xsmg2f2mx.fsf@kth.se>
References: <405C8B39.8080609@gmx.net> <405CAEC7.9080104@pobox.com>
 <405CFC85.70004@backtobasicsmgmt.com> <405DD9E2.4030308@pobox.com>
 <405DE18B.7090505@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-2480.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:bNBN45q3LkXGVQkDDM45/3vwCKs=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net> writes:

> IIRC, even a RAID-5 dm target is on its way to mainline and it was called
> something like "the last step to obsolete md". So the userspace approach
> seems the way to go.

RAID6 was recently added to md.  Hmm...

-- 
Måns Rullgård
mru@kth.se

