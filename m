Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbTJXAW6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 20:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbTJXAW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 20:22:58 -0400
Received: from mail.kroah.org ([65.200.24.183]:64432 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261906AbTJXAW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 20:22:58 -0400
Date: Thu, 23 Oct 2003 16:26:48 -0700
From: Greg KH <greg@kroah.com>
To: Giuliano Pochini <pochini@shiny.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 005 release
Message-ID: <20031023232648.GA21547@kroah.com>
References: <20031023001430.GA1837@kroah.com> <XFMail.20031023103313.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <XFMail.20031023103313.pochini@shiny.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 23, 2003 at 10:33:13AM +0200, Giuliano Pochini wrote:
> 
> Is it possible to make a disk appear always with the same name,
> regardless the order it is detected in the scsi chain (and possibly
> its scsi ID) ?

Yes, that is one of the main reasons udev is here.

thanks,

greg k-h
