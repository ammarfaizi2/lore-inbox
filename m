Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267346AbSLEQwa>; Thu, 5 Dec 2002 11:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267345AbSLEQwa>; Thu, 5 Dec 2002 11:52:30 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:38674 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267346AbSLEQwa>; Thu, 5 Dec 2002 11:52:30 -0500
Date: Thu, 5 Dec 2002 17:00:02 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] LSM changes for 2.5.50
Message-ID: <20021205170002.A30875@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linux-security-module@wirex.com
References: <20021205163152.GA2865@kroah.com> <20021205163234.GB2865@kroah.com> <20021205163300.GC2865@kroah.com> <20021205163339.GD2865@kroah.com> <20021205163406.GE2865@kroah.com> <20021205163541.GF2865@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021205163541.GF2865@kroah.com>; from greg@kroah.com on Thu, Dec 05, 2002 at 08:35:42AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2002 at 08:35:42AM -0800, Greg KH wrote:
> ChangeSet 1.797.142.4, 2002/12/04 16:56:51-06:00, greg@kroah.com
> 
> LSM: add the example rootplug module

I don't think that's the kind of module that should be merged..

