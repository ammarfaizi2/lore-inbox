Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946262AbWBDCbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946262AbWBDCbb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 21:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946266AbWBDCbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 21:31:31 -0500
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:44203 "EHLO
	pd4mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1946262AbWBDCba (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 21:31:30 -0500
Date: Fri, 03 Feb 2006 20:28:56 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Unable to read DVDs - what could be wrong?
In-reply-to: <5CfSW-7Ki-23@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <43E41168.20503@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <5CfSW-7Ki-23@gated-at.bofh.it>
User-Agent: Thunderbird 1.5 (Windows/20051201)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> ATAPI device hda:
>   Error: Hardware error -- (Sense key=0x04)
>   Tracking servo failure -- (asc=0x09, ascq=0x01)
>   The failed "Read Cd/Dvd Capacity" packet command was:
>   "25 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 "

That seems to me like a broken drive. It is possible for it to be unable 
to read DVDs but still read CDs, often these use different lasers.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

