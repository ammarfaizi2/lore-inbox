Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWDDT4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWDDT4y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 15:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWDDT4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 15:56:54 -0400
Received: from main.gmane.org ([80.91.229.2]:8162 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750829AbWDDT4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 15:56:53 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Wes Felter <wesley@felter.org>
Subject: Re: blade servers?
Date: Tue, 04 Apr 2006 14:55:24 -0500
Message-ID: <4432CF2C.8000208@felter.org>
References: <20060404024244.28E9A5F76B@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pixpat.austin.ibm.com
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
In-Reply-To: <20060404024244.28E9A5F76B@work.bitmover.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy wrote:
> I figured that people here would know.  If you were looking for blade
> servers and you were more interested in cost and heat generation than the
> most performance, what would you buy?

Consider systems based on the "Sossaman" Xeon LV processor; it has good 
integer performance and low power.

For example, at IBM we just released a new model of the BladeCenter HS20 
(model 7981); I've seen one of these servers using only 100W when 
running. Real servers are never going to be as cheap as the cheapest 
whiteboxes, but they do run cool.

Wes Felter - wesley@felter.org

