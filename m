Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264817AbUEEWUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264817AbUEEWUs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 18:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264821AbUEEWUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 18:20:48 -0400
Received: from mail.kroah.org ([65.200.24.183]:5297 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264817AbUEEWUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 18:20:47 -0400
Date: Wed, 5 May 2004 15:18:04 -0700
From: Greg KH <greg@kroah.com>
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Cc: vsu@altlinux.ru, "Mark M. Hoffman" <mhoffman@lightlink.com>
Subject: Re: [PATCH 2.6] Fix memory leaks in w83781d and asb100
Message-ID: <20040505221804.GE29885@kroah.com>
References: <20040403191023.08f60ff1.khali@linux-fr.org> <20040403202042.GA3898@sirius.home> <20040409173158.GC15820@kroah.com> <20040410165832.08e0c80d.khali@linux-fr.org> <20040417145309.4831f2b6.khali@linux-fr.org> <20040502220632.06cefb60.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040502220632.06cefb60.khali@linux-fr.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 02, 2004 at 10:06:32PM +0200, Jean Delvare wrote:
> 
> Greg, please apply if it looks good to you. Sorry for introducing the
> leak in the first place...

Looks a bit odd, but ok.

Applied, thanks.

greg k-h
