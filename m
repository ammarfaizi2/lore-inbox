Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbVLWD2N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbVLWD2N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 22:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbVLWD2N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 22:28:13 -0500
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:10174 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1030387AbVLWD2M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 22:28:12 -0500
X-ORBL: [70.231.233.23]
Date: Thu, 22 Dec 2005 19:28:09 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Diego Calleja <diegocg@gmail.com>
Cc: jmerkey@wolfmountaingroup.com, rostedt@goodmis.org, mrmacman_g4@mac.com,
       legal@lists.gnumonks.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, garbageout@sbcglobal.net
Subject: Re: blatant GPL violation of ext2 and reiserfs filesystem drivers
Message-ID: <20051223032809.GA31909@taniwha.stupidest.org>
References: <43AACF77.9020206@sbcglobal.net> <496FC071-3999-4E23-B1A2-1503DCAB65C0@mac.com> <1135283241.12761.19.camel@localhost.localdomain> <43AB32C1.1080101@wolfmountaingroup.com> <20051223025638.GA31381@taniwha.stupidest.org> <20051223041522.ac36635d.diegocg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051223041522.ac36635d.diegocg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2005 at 04:15:22AM +0100, Diego Calleja wrote:

> So, a GPL application running on top of a BSD-licensed kernel
> (or library) is illegal? I doubt it...

applications don't link with the kernel, modules do

i don't know if that makes modules legal or not, but it's certainly
not clear cut
