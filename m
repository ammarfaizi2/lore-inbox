Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTFXQVu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 12:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261939AbTFXQVu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 12:21:50 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:6077 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261151AbTFXQVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 12:21:49 -0400
Date: Tue, 24 Jun 2003 09:35:48 -0700
From: Greg KH <greg@kroah.com>
To: Seiichi Nakashima <nakasima@kumin.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux-2.5.73 compile error
Message-ID: <20030624163548.GA3914@kroah.com>
References: <200211220246.AA00001@prism.kumin.ne.jp> <200306232236.AA00004@prism.kumin.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306232236.AA00004@prism.kumin.ne.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 24, 2003 at 07:36:09AM +0900, Seiichi Nakashima wrote:
> Hi.
> 
> I update to linux-2.5.73 from linux-2.5.72.
> compile error occured.

Search the archives for the patch, or just enable CONFIG_HOTPLUG

thanks,

greg k-h
