Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264609AbUHGXQi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbUHGXQi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:16:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUHGXQi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:16:38 -0400
Received: from main.gmane.org ([80.91.224.249]:3290 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264609AbUHGXQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:16:34 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Sun, 08 Aug 2004 01:16:31 +0200
Message-ID: <yw1xy8kq1quo.fsf@kth.se>
References: <1091908405.5759.49.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 161.80-203-29.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:zEEnrZGV5lZ6m1VuSc84N/9Rpr0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sf.net> writes:

> Go ahead and drop support for old Linux kernels.
> Users with old kernels can use the old cdrecord.
> Handling Linux 2.6.x well means using /dev names.

And the funniest thing is all that's needed is to remove the silly
warning printed by cdrecord.

-- 
Måns Rullgård
mru@kth.se

