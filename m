Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264761AbTFLSDx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 14:03:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbTFLSDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 14:03:53 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:3987 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264761AbTFLSDx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 14:03:53 -0400
Date: Thu, 12 Jun 2003 10:57:52 -0700
From: Greg KH <greg@kroah.com>
To: lode leroy <lode_leroy@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 oops in ohci_hcd
Message-ID: <20030612175752.GB302@kroah.com>
References: <Sea2-F40xHyM96DX9QW0000c97a@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Sea2-F40xHyM96DX9QW0000c97a@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 12:32:48PM +0200, lode leroy wrote:
> Hi folks,
> can anyone enlighten me on this OOPS:
> 
> I'm trying to boot 2.5.70 on a system with only USB keyboard and mouse
> (i.e. no AT or PS/2 interface present)

Can you enter this into the bugzilla.kernel.org database so the proper
people will be bugged about it?

thanks,

greg k-h
