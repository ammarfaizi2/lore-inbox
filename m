Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264490AbTLEWif (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 17:38:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTLEWif
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 17:38:35 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:13960 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264490AbTLEWie
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 17:38:34 -0500
Date: Fri, 5 Dec 2003 14:38:25 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Kristian Peters <kristian.peters@korseby.net>
Cc: Andrea Arcangeli <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: oom killer in 2.4.23
Message-ID: <20031205223825.GQ29119@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Kristian Peters <kristian.peters@korseby.net>,
	Andrea Arcangeli <andrea@suse.de>,
	lkml <linux-kernel@vger.kernel.org>
References: <Z6Iv-7O2-29@gated-at.bofh.it> <Z8Ag-3BK-3@gated-at.bofh.it> <Zbyn-23P-29@gated-at.bofh.it> <20031205140520.39289a3a.kristian.peters@korseby.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031205140520.39289a3a.kristian.peters@korseby.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 05, 2003 at 02:05:20PM +0100, Kristian Peters wrote:

> Dec  5 13:34:41 adlib kernel: VM: killing process khexedit
> Dec  5 13:37:27 adlib kernel: VM: killing process mozilla-bin
> Dec  5 13:37:56 adlib kernel: VM: killing process mozilla-bin
> Dec  5 13:40:32 adlib kernel: VM: killing process XFree86

This is with 2.4.23?

Why is the VM killing anything if the oom-killer is removed?
