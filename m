Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751340AbWC3Rbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbWC3Rbp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 12:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbWC3Rbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 12:31:45 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:17847 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751340AbWC3Rbo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 12:31:44 -0500
Date: Thu, 30 Mar 2006 18:31:36 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>, beware <wimille@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Float numbers in module programming
Message-ID: <20060330173136.GZ27946@ftp.linux.org.uk>
References: <3fd7d9680603290634n6fabcdc7r193c30447acc1858@mail.gmail.com> <Pine.LNX.4.61.0603290955440.27913@chaos.analogic.com> <Pine.LNX.4.61.0603301010400.30783@yvahk01.tjqt.qr> <Pine.LNX.4.61.0603300739050.32259@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0603300739050.32259@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 08:09:14AM -0500, linux-os (Dick Johnson) wrote:
> For instance __all__ real numbers, except for transcendentals, can
> be represented as a ratio of two integers.

Dear wrongbot, "transcendentals" doesn't mean what you think it means.
