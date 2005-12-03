Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751084AbVLCATx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbVLCATx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 19:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbVLCATx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 19:19:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:34270 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751084AbVLCATw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 19:19:52 -0500
Date: Fri, 2 Dec 2005 16:19:34 -0800
From: Greg KH <greg@kroah.com>
To: art <art@usfltd.com>
Cc: linux-kernel@vger.kernel.org, jesper.juhl@gmail.com
Subject: Re: SMART over USB - problem
Message-ID: <20051203001934.GA31077@kroah.com>
References: <200512021728.AA16581602@usfltd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512021728.AA16581602@usfltd.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2005 at 05:28:42PM -0600, art wrote:
> SMART over USB - problem

Do you expect it to work?  USB storage is really scsi, so I doubt this
will ever work like you are expecting it to.

sorry,

greg k-h
