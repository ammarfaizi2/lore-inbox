Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262515AbVESOji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262515AbVESOji (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 10:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262532AbVESOji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 10:39:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:31890 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262515AbVESOj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 10:39:26 -0400
Date: Thu, 19 May 2005 07:42:48 -0700
From: Greg KH <greg@kroah.com>
To: Abhay_Salunke@Dell.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, Matt_Domsch@Dell.com,
       adobriyan@gmail.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Message-ID: <20050519144248.GA29167@kroah.com>
References: <367215741E167A4CA813C8F12CE0143B3ED382@ausx2kmpc115.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367215741E167A4CA813C8F12CE0143B3ED382@ausx2kmpc115.aus.amer.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 19, 2005 at 07:03:17AM -0500, Abhay_Salunke@Dell.com wrote:
> > On Wed, May 18, 2005 at 01:13:42PM -0500, Abhay Salunke wrote:
> > > This is a resubmit of the patch after incorporating all the inputs
> > > from revieweres. This also has a fix where the packets were leaked in
> > > the function create_packet line#227.
> > 
> > You did not address the issues I had with your use of binary sysfs files
> > for all file types.  Please fix that up.
> > 
> > Also, what's wrong with using the existing firmware interface in the
> > kernel?
> > 
> I am working on it; just wanted to address all the cosmetic issues
> first.

That is not what you stated above, hence my response.  Next time, please
be clearer.

greg k-h
