Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263324AbTCTXbC>; Thu, 20 Mar 2003 18:31:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263325AbTCTXbC>; Thu, 20 Mar 2003 18:31:02 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:36613 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S263324AbTCTXa6>; Thu, 20 Mar 2003 18:30:58 -0500
Date: Thu, 20 Mar 2003 23:41:56 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver changes for 2.5.65
Message-ID: <20030320234156.A21189@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	sensors@stimpy.netroedge.com
References: <20030320223046.GA4959@kroah.com> <10481995574110@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <10481995574110@kroah.com>; from greg@kroah.com on Thu, Mar 20, 2003 at 02:32:00PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 02:32:00PM -0800, Greg KH wrote:
>  	if (check_region(i801_smba, (isich4 ? 16 : 8))) {

Do I see a check_region here? :)
