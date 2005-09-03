Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbVICQHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbVICQHS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 12:07:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVICQHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 12:07:18 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:46097 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751468AbVICQHQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 12:07:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=PK2OVxUPCWMNwZNIslQepKhXcm9UULVy2Q3gsP5MSi/+mEDIi0GmWFyOtd0JJBaEXfuQj5cZOhphqApoA7CAJFjLERzE9tHeHC8saZxtmP9S/j93O5qZGw0GMG9i8+X9sk8pjUrkRrR4tLeC7qtwyaYAWcmpc/u7uKyySPvytn0=
Date: Sat, 3 Sep 2005 20:16:52 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ricardo Galli <gallir@uib.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.13
Message-ID: <20050903161652.GA20220@mipter.zuzino.mipt.ru>
References: <200508300157.27347.gallir@uib.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508300157.27347.gallir@uib.es>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2005 at 01:57:27AM +0200, Ricardo Galli wrote:
> 2.6.13 does not boot in my PPC (iBook, 500 MHz), it hangs just at the very 
> begining and the machines is automatically rebooted after a couple of 
> minutes.

I've filed a bug at kernel bugzilla so your report won't be lost. See
http://bugme.osdl.org/show_bug.cgi?id=5180

Please, register at http://bugme.osdl.org/createaccount.cgi and add
yourself to CC list.

