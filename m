Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262780AbVDAQOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbVDAQOT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 11:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262778AbVDAQOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 11:14:19 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:59776 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262805AbVDAQOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 11:14:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=lG7rn3rQHXgMcZRubGaCns2WcT8jDyxrJNqw5tZ85ZrGCPyAEcoMEqGty/0YViYXpc0PfatRLVgAcOYj2tCEiNLv6ziIo5ypqsLFqOb83uVZKZyl1IZBWPlniIQjHV3xlDFomWZHsiYSycmW2JATLXvnNWFsiT0qpwCek0ECm+k=
Message-ID: <40f323d0050401081423650536@mail.gmail.com>
Date: Fri, 1 Apr 2005 18:14:04 +0200
From: Benoit Boissinot <bboissin@gmail.com>
Reply-To: Benoit Boissinot <bboissin@gmail.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Subject: Re: 2.6.12-rc1 swsusp broken [Was Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel]
Cc: romano@dea.icai.upco.es, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <200503311309.50165.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050329110309.GA17744@pern.dea.icai.upco.es>
	 <d120d5000503310715cbc917@mail.gmail.com>
	 <20050331165007.GA29674@pern.dea.icai.upco.es>
	 <200503311309.50165.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 31, 2005 8:09 PM, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > It works, too. Which one is the best one?
> >
> 
> Both of them are needed as they address two different problems.
> 
I tried to boot with the 2 patches applied (and the patch which solves
noresume) and now touchpad/touchpoint no longer works (with this
kernel or with an older kernel).

Were the 2 patches safe or is it unrelated ?

Is there an easy way to get the touchpad back ?

regards,

Benoit
