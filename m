Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVC2BEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVC2BEl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 20:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbVC2BEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 20:04:40 -0500
Received: from irc.sh.nu ([216.239.132.110]:35036 "EHLO mail.3gstech.com")
	by vger.kernel.org with ESMTP id S262132AbVC2BEj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 20:04:39 -0500
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
From: Aaron Gyes <floam@sh.nu>
To: Greg KH <greg@kroah.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20050327181221.GB14502@kroah.com>
References: <1111886147.1495.3.camel@localhost>
	 <490243b66dc7c3f592df7a7d0769dcb7@mac.com>
	 <20050327181221.GB14502@kroah.com>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 17:04:37 -0800
Message-Id: <1112058277.14563.4.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-03-27 at 10:12 -0800, Greg KH wrote:
> No, that is not the general consensus at all.  Please search the
> archives and the web for summaries of this discussion topic the last
> time it came up.
> 
> greg k-h

Hi. I've searched the archives about this stuff. It looks like you
attempted to change the EXPORT_SYMBOL's to EXPORT_SYMBOL_GPL for sysfs
stuff back in February, and the issue in general has come up many times.
A few people have made the point that Linus has said that changing
EXPORT_SYMBOL to EXPORT_SYMBOL_GPL is not okay, that they are supposed
to start off as EXPORT_SYMBOL_GPL or somesuch. And it seems last time
you tried it, something made you change it back. 

Can you explain this, please?

