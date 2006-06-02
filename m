Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751371AbWFBMiJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371AbWFBMiJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 08:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWFBMiJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 08:38:09 -0400
Received: from mail21.bluewin.ch ([195.186.18.66]:53394 "EHLO
	mail21.bluewin.ch") by vger.kernel.org with ESMTP id S1751371AbWFBMiI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 08:38:08 -0400
Date: Fri, 2 Jun 2006 14:37:59 +0200
From: Roger Luethi <rl@hellgate.ch>
To: fonseka@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG: scheduling while atomic
Message-ID: <20060602123759.GA26323@k3.hellgate.ch>
References: <79a6fb1e0606020239i49c38effxc688c12f94d5da41@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <79a6fb1e0606020239i49c38effxc688c12f94d5da41@mail.gmail.com>
X-Operating-System: Linux 2.6.17-rc2 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 02 Jun 2006 10:39:01 +0100, fonseka@gmail.com wrote:
> recently I'm trying putting snmpd working on a old machine and ran into
> problems... everytime i try to spawn the snmpd process I got a kernel
> backtrace as follows, and the process never cames up:

The patch that caused the backtrace has been reverted in 2.6.17-rc5.

Roger
