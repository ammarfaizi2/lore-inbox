Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266841AbSLJWf6>; Tue, 10 Dec 2002 17:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266842AbSLJWf6>; Tue, 10 Dec 2002 17:35:58 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:45325 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266841AbSLJWf5>;
	Tue, 10 Dec 2002 17:35:57 -0500
Date: Tue, 10 Dec 2002 14:42:31 -0800
From: Greg KH <greg@kroah.com>
To: Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH 2.4.20-BK] usbnet typo
Message-ID: <20021210224230.GF8145@kroah.com>
References: <20021210162820.G18849@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021210162820.G18849@deep-space-9.dsnet>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 04:28:20PM +0100, Stelian Pop wrote:
> There is a typo in the latest usbnet driver which disables
> the compile of iPAQ specific code. 
> 
> With the attached patch, the new driver recognises the iPAQ
> and even works :*)

Thanks, I've added this to my tree and will send it on to Marcelo.

greg k-h
