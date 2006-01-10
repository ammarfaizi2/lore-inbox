Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932691AbWAJVLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932691AbWAJVLw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 16:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932695AbWAJVLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 16:11:51 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:56491 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932691AbWAJVLu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 16:11:50 -0500
Date: Tue, 10 Jan 2006 22:12:02 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add kernel.h to plist.h
Message-ID: <20060110211202.GA9683@elte.hu>
References: <200601101823.k0AINn2u032208@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200601101823.k0AINn2u032208@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> 	On ARM plist compilation fails due to missing container_of() So 
> I resolved it by adding kernel.h to plist.h .
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>

thanks, added.

	Ingo
