Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265801AbUATVQm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 16:16:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265803AbUATVQm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 16:16:42 -0500
Received: from poros.telenet-ops.be ([195.130.132.44]:18378 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S265801AbUATVQj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 16:16:39 -0500
From: Jan De Luyck <lkml@kcore.org>
To: mru@kth.se (=?iso-8859-1?q?M=E5ns?= =?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: HPT370 status [2.4/2.6]
Date: Tue, 20 Jan 2004 22:16:38 +0100
User-Agent: KMail/1.5.4
References: <1g0ZG-2q6-15@gated-at.bofh.it> <400D72B5.40705@gmx.at> <yw1x4quqo1gx.fsf@ford.guide>
In-Reply-To: <yw1x4quqo1gx.fsf@ford.guide>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200401202216.38420.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 January 2004 20:37, Måns Rullgård wrote:
> The Linux md driver already does many different raid variants,
> including mirroring.

Yes, but that's not really helpful if you're trying to get some sort of raid 
working over multiple operating systems. Unless somebody can point me to an 
MD driver for win32? ;p

Jan
-- 
Welcome to Lake Wobegon, where all the men are strong, the women are pretty,
and the children are above-average.
		-- Garrison Keillor

