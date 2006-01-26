Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932231AbWAZD4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932231AbWAZD4D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 22:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWAZDzv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 22:55:51 -0500
Received: from soohrt.org ([85.131.246.150]:39066 "EHLO quickstop.soohrt.org")
	by vger.kernel.org with ESMTP id S932231AbWAZDzf convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 22:55:35 -0500
Date: Thu, 26 Jan 2006 04:55:33 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: linux-kernel@vger.kernel.org
Subject: maintenance releases in GIT tree
Message-ID: <20060126035533.GA22994@quickstop.soohrt.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

why are the maintenance releases (2.6.x.y -- those with a .y in their
version number) not stored in the git tree accessible via
rsync://rsync1.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git/?
(Or -- are they, and I'm just not seeing them because I'm looking at the
wrong corner in the .git/ subdirectory?)

Shouldn't these minor changes be maintained in a branch for each
sublevel release? Or, if there's a reason not to do so, where is the
place they're being maintained at besides the main download locations
for patches?

Kind regards,
 Horst

-- 
PGP-Key 0xD40E0E7A
