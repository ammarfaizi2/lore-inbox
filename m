Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUBFTLl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 14:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265763AbUBFTLL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 14:11:11 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:55980 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265772AbUBFTK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 14:10:58 -0500
From: "Matthias Urlichs" <smurf@smurf.noris.de>
Date: Fri, 6 Feb 2004 19:47:51 +0100
To: Stephen Hemminger <shemminger@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VFS locking: f_pos thread-safe ?
Message-ID: <20040206184751.GC5581@kiste>
References: <402359E1.6000007@ntlworld.com> <20040206011630.42ed5de1.akpm@osdl.org> <40235DCC.2060606@ntlworld.com> <20040206013523.394d89f1.akpm@osdl.org> <pan.2004.02.06.10.19.57.885433@smurf.noris.de> <20040206101941.4cd9c882.shemminger@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206101941.4cd9c882.shemminger@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Stephen Hemminger:
> 
> Ever hear of pread/pwrite?

Sure I have, but the general idea had been to leave the work entirely to
the file system...

-- 
Matthias Urlichs     |     noris network AG     |     http://smurf.noris.de/
