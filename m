Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265062AbUAaSld (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 13:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265071AbUAaSld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 13:41:33 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:34965 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265062AbUAaSla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 13:41:30 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Sat, 31 Jan 2004 19:15:19 +0100
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: BUG: NTPL: waitpid() doesn't return?
Message-ID: <20040131181518.GB1815@kiste>
References: <20040131104606.GA25534@kiste> <20040131153743.GA13834@outpost.ds9a.nl> <20040131155155.GA1504@kiste> <20040131161805.GA15941@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040131161805.GA15941@outpost.ds9a.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

bert hubert:
> If they do not wait for a specific pid, the kernel is right. The kernel has
> no way of knowing which process a specific waitpid is waiting for otherwise!
> 
Please check my original mail again. The thread _is_ waiting for a
specific pid.

-- 
Matthias Urlichs     |     noris network AG     |     http://smurf.noris.de/
