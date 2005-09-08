Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932518AbVIHFRV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932518AbVIHFRV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 01:17:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932528AbVIHFRV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 01:17:21 -0400
Received: from web52601.mail.yahoo.com ([206.190.48.204]:49513 "HELO
	web52601.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932518AbVIHFRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 01:17:21 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=g6NysYw1wcHWeTUotUHlGlgeTYNwT0ABjlth0baqn5uReUwz8zGPrJs+lg8tYQ6w+kShd9p7jQ1dqCbKfTnWSL/NX9N1A3k/c9Hs0lP/NkseXm7a+75aSBwAnPjF8eGYnOwHgJ31AKiLjnPWMoeL772WU4Bi7a4OJdfTm/wbccs=  ;
Message-ID: <20050908051716.94223.qmail@web52601.mail.yahoo.com>
Date: Wed, 7 Sep 2005 22:17:16 -0700 (PDT)
From: nazim khan <naz_taurus@yahoo.com>
Subject: Re: How to find out kernel stack over flow?
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <431EA245.2040703@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Michal for your response,

I forgot to mention that I am using linux 2.4.26,
and STACKOVERFLOW option is not available here.

regards,
Nazim

--- Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
wrote:

> nazim khan wrote:
> > I suspect that one of my module that I am
> inserting in
> > the kernel may be causing the stack overflow which
> is
> > leading to kernel crash (may because it is
> corrupting
> > some one lese memory).
> > 
> > How can I find this out?
> 
> You could enable CONFIG_DEBUG_STACKOVERFLOW.
> If you showed us your module's source code, someone
> might see the bug.
> 
> Michal
> 



	
		
______________________________________________________
Click here to donate to the Hurricane Katrina relief effort.
http://store.yahoo.com/redcross-donate3/
