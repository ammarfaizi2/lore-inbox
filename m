Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUITU3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUITU3r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 16:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267330AbUITU1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 16:27:40 -0400
Received: from [205.233.219.253] ([205.233.219.253]:30672 "EHLO
	conifer.conscoop.ottawa.on.ca") by vger.kernel.org with ESMTP
	id S267333AbUITUXu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 16:23:50 -0400
Date: Mon, 20 Sep 2004 16:23:49 -0400
From: Jody McIntyre <lkml@modernduck.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, joq@io.com, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20040920202349.GI4273@conscoop.ottawa.on.ca>
References: <1094967978.1306.401.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094967978.1306.401.camel@krustophenia.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 01:46:18AM -0400, Lee Revell wrote:

> +	  Answer M to build realtime support as a Linux Security
> +	  Module.  Answering Y to build realtime capabilities into the
> +	  kernel makes no sense.

Why does this make no sense?

I tried answering Y and it oopsed on boot.  I'll try and track down/fix
what is happening later.

Jody
