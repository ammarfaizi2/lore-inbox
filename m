Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264158AbTEOSpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 14:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264162AbTEOSpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 14:45:54 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:2183 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264158AbTEOSpy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 14:45:54 -0400
Date: Thu, 15 May 2003 11:59:23 -0700
From: Greg KH <greg@kroah.com>
To: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: USB Storage oops in 2.5.69-bk8
Message-ID: <20030515185923.GB9796@kroah.com>
References: <20030515185221.GF20965@iucha.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030515185221.GF20965@iucha.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 01:52:21PM -0500, Florin Iucha wrote:
> Hello,
> 
> I get the following oops in 2.5.69-bk8 when I try to mount a Compact
> Flash card in a SanDisk adapter:

Can you make a bugzilla.kernel.org bug for this?

thanks,

greg k-h
