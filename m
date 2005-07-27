Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262261AbVG0VXB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbVG0VXB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 17:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262463AbVG0Uor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 16:44:47 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:63412 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S262441AbVG0UoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 16:44:14 -0400
Subject: Re: 2.6.12: no sound on SPDIF with emu10k1
From: Lee Revell <rlrevell@joe-job.com>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1122493585.3137.14.camel@hostmaster.org>
References: <1122493585.3137.14.camel@hostmaster.org>
Content-Type: text/plain
Date: Wed, 27 Jul 2005 16:44:11 -0400
Message-Id: <1122497052.22844.5.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-27 at 21:46 +0200, Thomas Zehetbauer wrote:
> Hi!
> 
> I cannot get my SB Live! 5.1's SPDIF (digital) output to work with
> kernel > 2.6.12. I have not changed my mixer configuration and it is
> still working when I boot 2.6.11.12 or earlier. I am using FC4 with
> alsa-lib-1.0.9rf-2.FC4 installed.

FC4 shipped a buggy ALSA version, I can't believe there are no updated
RPMs yet.

You need a newer ALSA.

Lee

