Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbWDYK4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbWDYK4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 06:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWDYK4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 06:56:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:24244 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932187AbWDYK4I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 06:56:08 -0400
To: "Charles Majola" <chmj@rootcore.co.za>
Cc: linux-kernel@vger.kernel.org
Subject: Re: EMT64T build error
References: <40cb3b290604250350n60c91bfapae0a622cfdbb731d@mail.gmail.com>
From: Andi Kleen <ak@suse.de>
Date: 25 Apr 2006 12:55:57 +0200
In-Reply-To: <40cb3b290604250350n60c91bfapae0a622cfdbb731d@mail.gmail.com>
Message-ID: <p73wtdd9b5u.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Charles Majola" <chmj@rootcore.co.za> writes:

> When i try to build 2.6.17-rc2 on amd64-generic machine with gcc 4.0.3
> (Ubuntu 64 bit) I get the following error (i386 builds fine)..

Do a make distclean after saving your .config.

-Andi
