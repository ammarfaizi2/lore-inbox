Return-Path: <linux-kernel-owner+w=401wt.eu-S1751053AbXAKRxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbXAKRxT (ORCPT <rfc822;w@1wt.eu>);
	Thu, 11 Jan 2007 12:53:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751318AbXAKRxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Jan 2007 12:53:19 -0500
Received: from rs27.luxsci.com ([66.216.127.24]:40601 "EHLO rs27.luxsci.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751053AbXAKRxT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Jan 2007 12:53:19 -0500
Message-ID: <45A67987.6030508@firmworks.com>
Date: Fri, 12 Jan 2007 01:53:11 +0800
From: Mitch Bradley <wmb@firmworks.com>
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
MIME-Version: 1.0
To: ron minnich <rminnich@gmail.com>
CC: "OLPC Developer's List" <devel@laptop.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Open Firmware device tree virtual filesystem
References: <13426df10701110939k21f7bb1dy38d2b34ca37a5a36@mail.gmail.com>
In-Reply-To: <13426df10701110939k21f7bb1dy38d2b34ca37a5a36@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Segher has a modification to the devtree patch that creates a lower 
level ops vector that can be implemented with callback or non-callback.

It is still being tested.



>
