Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265010AbUEKWq5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265010AbUEKWq5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 18:46:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265035AbUEKWq5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 18:46:57 -0400
Received: from adsl-67-120-171-161.dsl.lsan03.pacbell.net ([67.120.171.161]:15744
	"HELO home.linuxace.com") by vger.kernel.org with SMTP
	id S265010AbUEKWqz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 18:46:55 -0400
Date: Tue, 11 May 2004 15:46:54 -0700
From: Phil Oester <kernel@linuxace.com>
To: Kevin Stewart <kevins@netgate.net.nz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: in.tftpd + iptables kernel panic
Message-ID: <20040511224654.GA1630@linuxace.com>
References: <003701c4379e$0b75b380$2a1625ca@SKAVIN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003701c4379e$0b75b380$2a1625ca@SKAVIN>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this is fixed by the patch referenced here:

http://lists.netfilter.org/pipermail/netfilter-devel/2004-April/015054.html

Phil


On Wed, May 12, 2004 at 09:22:15AM +1200, Kevin Stewart wrote:
> I am running a stable debian install with tftpd 0.17-9 kernel 2.4.26
> While backing up cisco configs via tftp I caused a kernel panic
