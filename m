Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750833AbWERAi4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750833AbWERAi4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 May 2006 20:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWERAi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 May 2006 20:38:56 -0400
Received: from ipx10069.ipxserver.de ([80.190.240.67]:8867 "EHLO codeblau.de")
	by vger.kernel.org with ESMTP id S1750833AbWERAi4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 May 2006 20:38:56 -0400
Date: Thu, 18 May 2006 02:38:53 +0200
From: felix-linuxkernel@fefe.de
To: linux-kernel@vger.kernel.org
Subject: USB keyboard driver buggy, repeats keys
Message-ID: <20060518003853.GA9944@codeblau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I bought a USB keyboard recently, and I am a fast typist.

When I type "incoming" in a hurry, I press i, then n, then c, and
then I release i, then n, then c.  When I do this, Linux registers these
keystrokes:

  incin

I first thought this is a bug in my keyboard, so I tried the same thing
on Windows -- I get "inc", just as expected.

Please fix!

Felix
