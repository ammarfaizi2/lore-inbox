Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVDBRyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVDBRyB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 12:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261710AbVDBRyB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 12:54:01 -0500
Received: from pimout4-ext.prodigy.net ([207.115.63.98]:14214 "EHLO
	pimout4-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261708AbVDBRx7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 12:53:59 -0500
Date: Sat, 2 Apr 2005 09:53:45 -0800
From: Chris Wedgwood <cw@f00f.org>
To: ooyama eiichi <ooyama@tritech.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel stack size
Message-ID: <20050402175345.GA28710@taniwha.stupidest.org>
References: <20050403.024634.88477140.ooyama@tritech.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050403.024634.88477140.ooyama@tritech.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 03, 2005 at 02:46:34AM +0900, ooyama eiichi wrote:

> How can I know the rest size of the kernel stack.

you can't in a platfork-independant way

> (in my kernel driver)

*why* do you want to do this?
