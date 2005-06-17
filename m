Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261918AbVFQF4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261918AbVFQF4i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 01:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVFQF4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 01:56:38 -0400
Received: from are.twiddle.net ([64.81.246.98]:29573 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S261918AbVFQF4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 01:56:35 -0400
Date: Thu, 16 Jun 2005 22:56:34 -0700
From: Richard Henderson <rth@twiddle.net>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: getxpid, getxuid, getxgid
Message-ID: <20050617055634.GA24692@twiddle.net>
Mail-Followup-To: Linux Kernel ML <linux-kernel@vger.kernel.org>
References: <20050617053718.GA16080@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050617053718.GA16080@MAIL.13thfloor.at>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2005 at 07:37:18AM +0200, Herbert Poetzl wrote:
> I would like to know why alpha seems to be the only
> arch which has assembler code for some syscalls
> (like the sys_getx* calls)

Compatibility with OSF/1.


r~
