Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751108AbWBJMHr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751108AbWBJMHr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 07:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbWBJMHq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 07:07:46 -0500
Received: from animx.eu.org ([216.98.75.249]:48808 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1751108AbWBJMHq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 07:07:46 -0500
Date: Fri, 10 Feb 2006 07:11:07 -0500
From: Wakko Warner <wakko@animx.eu.org>
To: Greg KH <greg@kroah.com>
Cc: Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Let's get rid of  ide-scsi
Message-ID: <20060210121107.GC27814@animx.eu.org>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Alex Davis <alex14641@yahoo.com>, linux-kernel@vger.kernel.org
References: <20060210002148.37683.qmail@web50201.mail.yahoo.com> <20060210003614.GA26114@animx.eu.org> <20060210052404.GB29421@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060210052404.GB29421@kroah.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Feb 09, 2006 at 07:36:14PM -0500, Wakko Warner wrote:
> > 
> > I am also against the seperate USB block layer, I personally saw no use in
> > it.
> 
> What "seperate USB block layer"?

Maybe not a "block layer", but there was this Under drivers/block devices in
the config:
Low Performance USB Block driver

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
