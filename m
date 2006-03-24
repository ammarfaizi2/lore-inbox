Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932635AbWCXBWO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932635AbWCXBWO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 20:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932637AbWCXBWO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 20:22:14 -0500
Received: from nommos.sslcatacombnetworking.com ([67.18.224.114]:56203 "EHLO
	nommos.sslcatacombnetworking.com") by vger.kernel.org with ESMTP
	id S932635AbWCXBWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 20:22:13 -0500
In-Reply-To: <20060324011349.GC28500@kroah.com>
References: <Pine.LNX.4.44.0603231854270.29782-100000@gate.crashing.org> <20060324011349.GC28500@kroah.com>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B520BB15-6EF6-4138-95E5-A97DDCE90839@kernel.crashing.org>
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] i2c: Add support for virtual I2C adapters
Date: Thu, 23 Mar 2006 19:22:59 -0600
To: Greg KH <greg@kroah.com>
X-Mailer: Apple Mail (2.746.3)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - nommos.sslcatacombnetworking.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.crashing.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 23, 2006, at 7:13 PM, Greg KH wrote:

> On Thu, Mar 23, 2006 at 06:55:31PM -0600, Kumar Gala wrote:
>> +EXPORT_SYMBOL(i2c_add_virt_adapter);
>> +EXPORT_SYMBOL(i2c_del_virt_adapter);
>
> EXPORT_SYMBOL_GPL() perhaps?

Got no issue with making that change.

- kumar
