Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbUCGOuO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 09:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbUCGOuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 09:50:14 -0500
Received: from gprs40-154.eurotel.cz ([160.218.40.154]:15166 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262042AbUCGOuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 09:50:12 -0500
Date: Sun, 7 Mar 2004 15:49:21 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Some highmem pages still in use after shrink_all_memory()?
Message-ID: <20040307144921.GA189@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

For swsusp, I need to free as much memory as possible. Well, and it
would be great if no highmem pages remained, so that I would not have
to deal with that. Is that possible?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
