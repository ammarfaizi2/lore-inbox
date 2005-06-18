Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVFRAOj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVFRAOj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 20:14:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbVFRAOj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 20:14:39 -0400
Received: from femail.waymark.net ([206.176.148.84]:55768 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S261278AbVFRAOi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 20:14:38 -0400
Date: 18 Jun 2005 00:00:32 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: Re: 2.6.11: nforce3 250gb lockups
To: linux-kernel@vger.kernel.org
Message-ID: <803051.d19810@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> Denis Vlasenko wrote to Xavier Bestel <=-

 DV> I was thinking more of using hdparm to downgrade DMA to lower
 DV> speeds, not disabling it altogether.
i haven't checked recently, but this system has [had] audio
corruption with alsa cs4235 using the bootup udma2 mode, but not with
mdma2 - set now from a boot script.
--
