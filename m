Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262680AbTCTXm1>; Thu, 20 Mar 2003 18:42:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbTCTXlO>; Thu, 20 Mar 2003 18:41:14 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:6406 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262284AbTCTXkt>;
	Thu, 20 Mar 2003 18:40:49 -0500
Date: Thu, 20 Mar 2003 15:52:03 -0800
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       sensors@stimpy.netroedge.com
Subject: Re: [PATCH] i2c driver changes for 2.5.65
Message-ID: <20030320235203.GA10249@kroah.com>
References: <20030320223046.GA4959@kroah.com> <10481995574110@kroah.com> <20030320234156.A21189@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030320234156.A21189@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 20, 2003 at 11:41:56PM +0000, Christoph Hellwig wrote:
> On Thu, Mar 20, 2003 at 02:32:00PM -0800, Greg KH wrote:
> >  	if (check_region(i801_smba, (isich4 ? 16 : 8))) {
> 
> Do I see a check_region here? :)

You really need to start reading all of the patches in the series :)

thanks,

greg k-h
