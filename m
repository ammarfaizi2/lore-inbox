Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264045AbUFXJS6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264045AbUFXJS6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 05:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUFXJS6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 05:18:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43720 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264045AbUFXJSw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 05:18:52 -0400
Message-ID: <40DA9C6E.8050205@pobox.com>
Date: Thu, 24 Jun 2004 05:18:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: Chris Friesen <cfriesen@nortelnetworks.com>,
       Mariusz Mazur <mmazur@kernel.pl>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.7.0
References: <200406240102.23162.mmazur@kernel.pl> <40DA16E8.6070902@nortelnetworks.com> <20040624055832.GA10531@kroah.com>
In-Reply-To: <20040624055832.GA10531@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Wed, Jun 23, 2004 at 07:48:56PM -0400, Chris Friesen wrote:
> 
>>Maybe this should be a topic for the kernel summit or a BOF session at
>>OLS?
> 
> 
> I don't see any objections, just no patches have been submitted that do
> this work.  Why would a BOF be needed to create a patch?  :)

Agreed...  It's just getting 'down and dirty' and separating the ABI 
stuff from the non-ABI stuff.  It's not necessarily difficult, just 
incredibly long and tedious, and potentially political.

But nonetheless a worthy goal :)

	Jeff



