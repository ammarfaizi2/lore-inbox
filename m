Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261427AbTJ1Sy2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 13:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTJ1Sy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 13:54:28 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:18856 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261427AbTJ1Sx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 13:53:56 -0500
Message-ID: <3F9EB933.6030202@nortelnetworks.com>
Date: Tue, 28 Oct 2003 13:45:07 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Mark Bellon <mbellon@mvista.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: ANNOUNCE: User-space System Device Enumeration (uSDE)
References: <Pine.LNX.4.33.0310280901490.7139-100000@osdlab.pdx.osdl.net> <3F9EB17F.9020308@mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Bellon wrote:

> The uSDE ideas and implementation was started with the OSDL requirements 
> in August of 2002.
> This is the first time any form of it has been posted. From 
> time-to-time, since the project started, ideas related to it have been 
> floated with the community. The feedback was carefully listened to and 
> utitized in the implementation that was just posted.

When floating those ideas, was it clear that an implementation was being 
actively developed?  You could have said something when Greg posted 
version 0.1 of udev back in April.

If people had known that this was in the works, they might have chosen 
to concentrate on this rather than udev. As it is, there has been 
significant effort put into udev, and now there is duplicated 
functionality and more work will be required to figure out how to 
combine them (if that is the chosen path).

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

