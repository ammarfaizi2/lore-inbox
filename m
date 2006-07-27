Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161042AbWG0Tez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161042AbWG0Tez (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 15:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbWG0Tez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 15:34:55 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:20218 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751046AbWG0Tez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 15:34:55 -0400
Date: Thu, 27 Jul 2006 13:34:53 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Can we ignore errors in mcelog if the server is running fine
In-reply-to: <fa.2RkKSvRvPsGNSGCsUHQ9gQ8qlrg@ifi.uio.no>
To: Vikas Kedia <kedia.vikas@gmail.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <44C9155D.5060102@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.2RkKSvRvPsGNSGCsUHQ9gQ8qlrg@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vikas Kedia wrote:
> The server seems to be running fine. A. can I ignore the following
> mcelog errors ? B. If not what should i do to stop the server from
> reporting mcelog errors.

Looks like data cache ECC errors, meaning the CPU 0 is faulty. 
Eventually if it's not replaced there will likely be some uncorrectable 
errors and the system will likely crash.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

