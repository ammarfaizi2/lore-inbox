Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265340AbSJXHwS>; Thu, 24 Oct 2002 03:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265342AbSJXHwR>; Thu, 24 Oct 2002 03:52:17 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:5136 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265340AbSJXHwQ>;
	Thu, 24 Oct 2002 03:52:16 -0400
Date: Thu, 24 Oct 2002 00:56:57 -0700
From: Greg KH <greg@kroah.com>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: One for the Security Guru's
Message-ID: <20021024075656.GB20295@kroah.com>
References: <20021023130251.GF25422@rdlg.net> <24321.1035379233@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24321.1035379233@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 11:20:33PM +1000, Keith Owens wrote:
> 
> LSM with its fine grained security model might help in this area, but
> don't hold your breath.  LSM has not been accepted into the kernel yet.

Um, what's sitting in the security and include/linux/security.h files in
the 2.5 tree then?  :)

In short, it's in, but not "every" part of it, yet.

thanks,

greg k-h
