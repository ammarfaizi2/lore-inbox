Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWAWSqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWAWSqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 13:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964888AbWAWSqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 13:46:19 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:5293 "EHLO
	aria.kroah.org") by vger.kernel.org with ESMTP id S964886AbWAWSqS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 13:46:18 -0500
Date: Mon, 23 Jan 2006 10:46:21 -0800
From: Greg KH <gregkh@suse.de>
To: "V. Ananda Krishnan" <mansarov@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       rmk@arm.linux.org.uk, akpm@osdl.org
Subject: Re: [PATCH]-jsm driver fix for linux-2.6.16-rc1
Message-ID: <20060123184621.GA6744@suse.de>
References: <43D1099E.3050509@us.ibm.com> <1137781399.24161.30.camel@localhost.localdomain> <43D52023.4090607@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D52023.4090607@us.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2006 at 12:27:47PM -0600, V. Ananda Krishnan wrote:
> I am submitting the revised patch. We removed the use of jsm-rawreadok 
> feature. Greg's suggestions are also taken care of.  Let me have the 
> feed-back.

No, you are still using spaces instead of tabs in places.  Please fix
that.

thanks,

greg k-h
