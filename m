Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264729AbSLEQtu>; Thu, 5 Dec 2002 11:49:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264890AbSLEQtu>; Thu, 5 Dec 2002 11:49:50 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:58377 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264729AbSLEQtt>;
	Thu, 5 Dec 2002 11:49:49 -0500
Message-ID: <3DEF8570.5000401@pobox.com>
Date: Thu, 05 Dec 2002 11:57:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@steeleye.com>
CC: Patrick Mochel <mochel@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [BKPATCH] bus notifiers for the generic device model
References: <200212051614.gB5GEUN02667@localhost.localdomain>
In-Reply-To: <200212051614.gB5GEUN02667@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> If you envisage us never eliminating the driver specific probe and remove 
> routines, I'm happy.  I'm less happy if there will come a day when I have to 
> revisit all the converted drivers to do the elimination.


Likewise...  I think with very minor changes, existing PCI-API-compliant 
drivers should stay pretty much the same as they are now.

