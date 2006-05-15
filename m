Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWEOPKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWEOPKV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964962AbWEOPKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:10:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:44991 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964959AbWEOPKT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:10:19 -0400
Date: Mon, 15 May 2006 08:08:10 -0700
From: Greg KH <greg@kroah.com>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>,
       Fawad Lateef <fawadlateef@gmail.com>, jjoy@novell.com,
       "Nutan C." <nutanc@esntechnologies.co.in>,
       "Mukund JB." <mukundjb@esntechnologies.co.in>, gauravd.chd@gmail.com,
       bulb@ucw.cz, Shakthi Kannan <cyborg4k@yahoo.com>
Subject: Re: GPL and NON GPL version modules
Message-ID: <20060515150810.GA13905@kroah.com>
References: <AF63F67E8D577C4390B25443CBE3B9F70928E8@esnmail.esntechnologies.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AF63F67E8D577C4390B25443CBE3B9F70928E8@esnmail.esntechnologies.co.in>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2006 at 03:23:30PM +0530, Srinivas G. wrote:
> Dear All,
>  
> I have a small doubt about the GPL and NON GPL version modules.
> 
> If I have a module called module A which uses the GPL code and module B
> uses the NON GPL (proprietary) code. If the module A depends on module
> B, is it possible to load these modules? That is some of the functions
> (which are defined in module B) are called from module A.
> 
> Will it be violating any GPL Rules?

Contact a lawyer, a technical mailing list can not give legal advice.

Good luck,

greg k-h
