Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287971AbSABU0g>; Wed, 2 Jan 2002 15:26:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287948AbSABU03>; Wed, 2 Jan 2002 15:26:29 -0500
Received: from tmhoyle.gotadsl.co.uk ([195.149.46.162]:31238 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S287968AbSABUZw>;
	Wed, 2 Jan 2002 15:25:52 -0500
Mailbox-Line: From tmh@nothing-on.tv  Wed Jan  2 20:25:48 2002
Message-ID: <3C336CD0.9060905@nothing-on.tv>
Date: Wed, 02 Jan 2002 20:25:52 +0000
From: Tony Hoyle <tmh@nothing-on.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011224
MIME-Version: 1.0
To: timothy.covell@ashavan.org
Cc: adrian kok <adriankok2000@yahoo.com.hk>, linux-kernel@vger.kernel.org
Subject: Re: system.map
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com> <200201021930.g02JUCSr021556@svr3.applink.net> <3C336209.8000808@nothing-on.tv> <200201022006.g02K6vSr021827@svr3.applink.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Covell wrote:


> Not on grub.  I quote:


It works fine on grub.  I use grub.

make install is completely installation agnostic.  It just calls 
/sbin/installkernel with the paths of the various files.  On any sane 
distribution this will work.  If it doesn't it's only a shell script 
with a few symlink & copy commands in it... just write your own.

Tony

