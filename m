Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262065AbUGEXLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262065AbUGEXLg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 19:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbUGEXLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 19:11:36 -0400
Received: from mail.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:62338 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S262065AbUGEXLe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 19:11:34 -0400
Date: Tue, 6 Jul 2004 01:11:31 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: post 2.6.7 BK change breaks Java?
Message-ID: <20040705231131.GA5958@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've pulled from the linux-2.6 BK tree some post-2.6.7 version, compiled
and installed it, and it breaks Java, standalone or plugged into
firefox, the symptom is that the application catches SIGKILL. This
didn't happen with stock 2.6.7 and doesn't happen with 2.6.6 either.

Is there any particular change I should try backing out?

TIA,

-- 
Matthias Andree

Encrypted mail welcome: my GnuPG key ID is 0x052E7D95 (PGP/MIME preferred)
