Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbULWOH2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbULWOH2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 09:07:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbULWOH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 09:07:28 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:44726 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S261241AbULWOHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 09:07:24 -0500
Date: Thu, 23 Dec 2004 15:07:24 +0100
From: bert hubert <ahu@ds9a.nl>
To: krishna <krishna.c@globaledgesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Significance of  variable arguments
Message-ID: <20041223140724.GA12836@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	krishna <krishna.c@globaledgesoft.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <41CABBF1.6050304@globaledgesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41CABBF1.6050304@globaledgesoft.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2004 at 06:07:05PM +0530, krishna wrote:
> Hi All,
> 
> Can any one tell me a source which explains the significance of variable 
> arguments.

This is like printf, execl etc etc. Common C usage to pass variable number
of arguments, or even variable types.

-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
