Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261544AbSLCOyI>; Tue, 3 Dec 2002 09:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261545AbSLCOyI>; Tue, 3 Dec 2002 09:54:08 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40201 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261544AbSLCOyH>;
	Tue, 3 Dec 2002 09:54:07 -0500
Date: Tue, 3 Dec 2002 08:01:41 -0800
From: Greg KH <greg@kroah.com>
To: Dragan Stancevic <visitor@xalien.org>
Cc: linux-security-module@wirex.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC] LSM fix for stupid "empty" functions
Message-ID: <20021203160141.GA20844@kroah.com>
References: <20021201083056.GJ679@kroah.com> <20021201172156.A17028@infradead.org> <20021201182644.GD8829@kroah.com> <200212021837.52312.visitor@xalien.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212021837.52312.visitor@xalien.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 02, 2002 at 06:37:52PM -0800, Dragan Stancevic wrote:
> 
> not that I am trying to be a PITA but where did you get the information that 
> initialized variables live in .bss?

I was incorrect, as was pointed out to me about 15 minutes after sending
that email :)

thanks,

greg k-h
