Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261994AbTETACt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 20:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262316AbTETACt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 20:02:49 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:38131 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261994AbTETACs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 20:02:48 -0400
Date: Mon, 19 May 2003 17:15:20 -0700
From: Greg KH <greg@kroah.com>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: usbserial OOPS in 2.5.69-bk4
Message-ID: <20030520001520.GA28148@kroah.com>
References: <1053380614.1141.44.camel@torrey.et.myrio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053380614.1141.44.camel@torrey.et.myrio.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 02:43:34PM -0700, Torrey Hoffman wrote:
> I got a non-fatal oops while trying to hotsync my Handspring Visor. 
> My system is still running as I send this email, but the hotsync didn't
> work.

Can you try with the latest -bk tree?  I can successfully sync using it,
but did have some problems with a few of the older revs.

thanks,

greg k-h
