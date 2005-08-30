Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVH3Tpx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVH3Tpx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 15:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVH3Tpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 15:45:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:9425 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932424AbVH3Tpw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 15:45:52 -0400
Date: Tue, 30 Aug 2005 12:44:35 -0700
From: Greg KH <greg@kroah.com>
To: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
Cc: Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com
Subject: Re: [PATCH 2.6] I2C: Drop I2C_DEVNAME and i2c_clientname
Message-ID: <20050830194435.GF12171@kroah.com>
References: <20050815195704.7b61206e.khali@linux-fr.org> <1124741348.4516.51.camel@localhost> <20050825001958.63b2525c.khali@linux-fr.org> <1125360762.6186.29.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125360762.6186.29.camel@localhost>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2005 at 09:12:42PM -0300, Mauro Carvalho Chehab wrote:
> 
> 	I have a question for you about I2C: why i2c_driver doesn't have a
> generic pointer to keep priv data (like i2c_adapter) ? 

Because no one has sent in a patch to add it :)

thanks,

greg k-h
