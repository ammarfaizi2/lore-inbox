Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288473AbSAHWGQ>; Tue, 8 Jan 2002 17:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288511AbSAHWGB>; Tue, 8 Jan 2002 17:06:01 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:15886 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288486AbSAHWD7>;
	Tue, 8 Jan 2002 17:03:59 -0500
Date: Tue, 8 Jan 2002 14:01:50 -0800
From: Greg KH <greg@kroah.com>
To: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
Message-ID: <20020108220149.GA15816@kroah.com>
In-Reply-To: <3C3B664B.3060103@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3B664B.3060103@intel.com>
User-Agent: Mutt/1.3.25i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 11 Dec 2001 19:55:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 11:36:11PM +0200, Vladimir Kondratiev wrote:
> Hello,
> Modern C standard (C99) defines __FUNCTION__ as if immediately after 
> function open brace string with function name is declared. Thus, it's 
> invalid to use string concatenations like __FILE__ ":" __FUNCTION__.

Hi,

Can you point me to the place in the spec this is defined?  I don't see
__FUNCTION__ defined anywhere in the ISO/IEC 9899:1999 (the official C99)
specification.

thanks,

greg k-h
