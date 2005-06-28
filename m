Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVF1O3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVF1O3K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 10:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261685AbVF1O3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 10:29:00 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:6867 "EHLO
	pd3mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261806AbVF1O2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 10:28:42 -0400
Date: Tue, 28 Jun 2005 08:28:08 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Kswapd flaw
In-reply-to: <4koWT-5Iy-21@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <42C15E78.6010609@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=ISO-8859-1
Content-transfer-encoding: 7bit
X-Accept-Language: en-us, en
References: <4knRo-4Li-9@gated-at.bofh.it> <4koWT-5Iy-21@gated-at.bofh.it>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Boldi wrote:
> Nix,
> You should only fault if you have a place to fault to, as into a swap.
> Without swap faulting is overkill.
> 
> Is it possible to change kswapd's default behaviour to not fault if there is
> no swap?

See Michal Schmidt's posting. It CAN fault if there is no swap.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

