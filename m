Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932195AbWHPTkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932195AbWHPTkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 15:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbWHPTkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 15:40:11 -0400
Received: from hera.kernel.org ([140.211.167.34]:25224 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S932195AbWHPTkK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 15:40:10 -0400
From: Len Brown <len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Organization: Intel Open Source Technology Center
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.18-rc4-mm1
Date: Wed, 16 Aug 2006 15:41:49 -0400
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <fa.nURugTWtyfQKAbvUB0DbTkmyPAY@ifi.uio.no> <44E28989.1010904@shaw.ca>
In-Reply-To: <44E28989.1010904@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608161541.50041.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 August 2006 22:57, Robert Hancock wrote:
> Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc4/2.6.18-rc4-mm1/
> 
> Warnings and an oops on suspend to disk:
> 
> http://www.roberthancock.com/oops1.jpg
> http://www.roberthancock.com/oops2.jpg
> http://www.roberthancock.com/oops3.jpg
> http://www.roberthancock.com/oops4.jpg
> http://www.roberthancock.com/oops5.jpg
> http://www.roberthancock.com/oops6.jpg
> http://www.roberthancock.com/oops7.jpg
> http://www.roberthancock.com/oops8.jpg

Re: acpi_os_wait_sempahore()

please try the patch here:
http://bugzilla.kernel.org/show_bug.cgi?id=6810

thanks,
-Len
