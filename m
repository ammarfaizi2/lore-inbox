Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUFJQU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUFJQU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 12:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUFJQU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 12:20:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:34524 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261631AbUFJQU6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 12:20:58 -0400
Date: Thu, 10 Jun 2004 09:19:52 -0700
From: Greg KH <greg@kroah.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] Suppress platform device suffixes - take 2
Message-ID: <20040610161952.GA32144@kroah.com>
References: <200406090221.24739.dtor_core@ameritech.net> <20040609231920.GA9132@kroah.com> <200406100140.30621.dtor_core@ameritech.net> <200406100142.14861.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200406100142.14861.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2004 at 01:42:13AM -0500, Dmitry Torokhov wrote:
> 
> ===================================================================
> 
> 
> ChangeSet@1.1766, 2004-06-09 23:55:59-05:00, dtor_core@ameritech.net
>   sysfs: Do not add numeric suffix to platform device name if device
>          id is set to -1. This can be used when there can be only one
>          instance of a device (like i8042).
>   
>   Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Applied, thanks.

greg k-h
