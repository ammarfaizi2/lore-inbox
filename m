Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261192AbTIDXSx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 19:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbTIDXSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 19:18:53 -0400
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:47746 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S261192AbTIDXSF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 19:18:05 -0400
Message-ID: <3F57C951.8030606@pacbell.net>
Date: Thu, 04 Sep 2003 16:22:57 -0700
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Greg KH <greg@kroah.com>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>,
       Linux usb mailing list 
	<linux-usb-devel@lists.sourceforge.net>
Subject: Re: [linux-usb-devel] Re: USB modem no longer detected in -test4
References: <20030903191701.GA2798@elf.ucw.cz> <20030903223936.GA7418@kroah.com> <20030903224412.GA6822@atrey.karlin.mff.cuni.cz> <20030903233602.GA1416@kroah.com> <20030904212417.GF31590@mail.jlokier.co.uk>
In-Reply-To: <20030904212417.GF31590@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Greg KH wrote:
> 
>>2.5.62???  You are going to have to help narrow it down a bit more :)
> 
> 
> It worked fine in 2.5.75 too.  I have the same problem as Pavel, with
> a different USB modem in -test4.

And ... does my suggestion to Pavel then improve things?

   http://marc.theaimsgroup.com/?l=linux-kernel&m=106263361810553&w=2

referring to this patch

   http://marc.theaimsgroup.com/?l=linux-usb-devel&m=106260875713372&w=2

Same symptoms should in this case mean same fix ...

- Dave


