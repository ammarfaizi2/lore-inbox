Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTKNBmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 20:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264481AbTKNBmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 20:42:43 -0500
Received: from mail.kroah.org ([65.200.24.183]:6041 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262130AbTKNBmm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 20:42:42 -0500
Date: Thu, 13 Nov 2003 17:11:54 -0800
From: Greg KH <greg@kroah.com>
To: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
Cc: Simon Vogl <simon@voxel.at>, Daniel Smolik <marvin@sitour.cz>
Subject: Re: I2C parallel port adapters drivers
Message-ID: <20031114011154.GJ16352@kroah.com>
References: <20031102132342.79920c6f.khali@linux-fr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031102132342.79920c6f.khali@linux-fr.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 02, 2003 at 01:23:42PM +0100, Jean Delvare wrote:
> 
> I think we should merge the four drivers into a single one, or at least
> (if there is one good reason to access the parallel port using two
> different methods) the last three drivers into a single one. I volunteer
> to do so, but I want to ear opinions about the idea before going on.

Sounds like a good idea.

greg k-h
