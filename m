Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261732AbUCBSbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 13:31:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261731AbUCBSbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 13:31:23 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:25528 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261732AbUCBSbW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 13:31:22 -0500
Message-ID: <4044D2ED.401@pobox.com>
Date: Tue, 02 Mar 2004 13:31:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortelnetworks.com>
CC: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] kbuild: Add a binary only .o file to a module
References: <20040301214617.GA7777@mars.ravnborg.org> <4044A692.40106@nortelnetworks.com>
In-Reply-To: <4044A692.40106@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> Sam Ravnborg wrote:
> 
>> Any objections from having this in the kernel?
>> [Please, please, this is only for 'legal' binary modules - so do not
>> start the usual 'binary modules should be GPL discussion'].
>>
>> This is a small step towards better support for external modules.
> 
> 
> I'll put in a vote for this.  Unfortunately we have some hardware for 
> which the only drivers available use binary blobs.


Shouldn't we discourage this practice where feasible?  :)

	Jeff



