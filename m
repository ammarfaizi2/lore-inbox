Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVDFE3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVDFE3M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 00:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262103AbVDFE3M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 00:29:12 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24913 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S262102AbVDFE3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 00:29:07 -0400
Date: Tue, 05 Apr 2005 22:27:51 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Hyperthreading and Kernel 2.4
In-reply-to: <3PwnE-7fl-15@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42536547.9040806@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <3PwnE-7fl-15@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

duncan@devilnews.de wrote:
> Hey,
> 
> I apologize in advance if this is not the right place
> to ask. Feel free to redirect me there :)
> 
> I just wanted to know if the 2.4 kernel is aware of
> hyperthreading the same way the 2.6 kernel ist or if
> the issues posted earlier

I'm not sure if the stock 2.4 kernels ever had good HT support, but the 
patched 2.4.20 kernel in Red Hat 9, for example, seems to handle it 
reasonably well..

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

