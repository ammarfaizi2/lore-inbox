Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267374AbUIWXLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267374AbUIWXLu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 19:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267410AbUIWXI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 19:08:57 -0400
Received: from chiark.greenend.org.uk ([193.201.200.170]:18660 "EHLO
	chiark.greenend.org.uk") by vger.kernel.org with ESMTP
	id S267374AbUIWXIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 19:08:16 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Warn people that ipchains and ipfwadm are going away.
In-Reply-To: <1095962839.4974.965.camel@cube>
References: <1095962839.4974.965.camel@cube>
Date: Fri, 24 Sep 2004 00:08:13 +0100
Message-Id: <E1CAchB-0004VU-00@chiark.greenend.org.uk>
From: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan <albert@users.sf.net> wrote:

> Who is doing a 32-bit userland on x86-64, and WTF for?
> Why do they not also run a 32-bit kernel?

Debian will be shipping a 32-bit userland with a 64-bit kernel. The
reasons are long, awkward, and mostly uninteresting. The reason for
shipping a 64-bit kernel is that it makes it easier for users who
require large quantities of VM to obtain it.

-- 
Matthew Garrett | mjg59-chiark.mail.linux-rutgers.kernel@srcf.ucam.org
