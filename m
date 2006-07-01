Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751863AbWGAQdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751863AbWGAQdE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 12:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWGAQdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 12:33:04 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:11488 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S1751536AbWGAQdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 12:33:03 -0400
Date: Sat, 1 Jul 2006 18:33:01 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
Subject: ext4 features
Message-ID: <20060701163301.GB24570@cip.informatik.uni-erlangen.de>
Mail-Followup-To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	Theodore Ts'o <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11-2006-06-13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
I would like to know which new features are planed to be incorported by
ext4. So far I only read about supporting bigger filesystems to fit
recent hardware developments. So are there any other big goals for ext4?

What I personally would like to see most in ext4 are

        * checksums for data
        * and snapshots on filesystem basis

But I guess that this is way out of scope for ext4.

        Thomas
