Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbVIWO3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbVIWO3y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 10:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbVIWO3x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 10:29:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:59582 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751019AbVIWO3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 10:29:53 -0400
Date: Fri, 23 Sep 2005 07:29:27 -0700
From: Greg KH <greg@kroah.com>
To: Srihari Vijayaraghavan <sriharivijayaraghavan@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] USB Storage & D state processes
Message-ID: <20050923142927.GA13433@kroah.com>
References: <20050923131642.12688.qmail@web52614.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050923131642.12688.qmail@web52614.mail.yahoo.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2005 at 11:16:42PM +1000, Srihari Vijayaraghavan wrote:
> Hardware:
> Athlon 64
> VIA K8T 800
> 
> Software:
> FC4
> 2.6.14-rc2 (vanilla)

Try 2.6.14-rc2-git2, it should be fixed there.

thanks,

greg k-h
