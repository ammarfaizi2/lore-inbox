Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751022AbWDJF5w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbWDJF5w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 01:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751023AbWDJF5w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 01:57:52 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:39064 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S1751022AbWDJF5v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 01:57:51 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] deinline few large functions in inet6 code
Date: Mon, 10 Apr 2006 08:57:22 +0300
User-Agent: KMail/1.8.2
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200604100833.37016.vda@ilport.com.ua> <20060409.224913.11924710.davem@davemloft.net>
In-Reply-To: <20060409.224913.11924710.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604100857.22874.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 10 April 2006 08:49, David S. Miller wrote:
> From: Denis Vlasenko <vda@ilport.com.ua>
> Date: Mon, 10 Apr 2006 08:33:36 +0300
> 
> > Deinline a few functions which produce 200+ bytes of code.
> > 
> > Signed-off-by: Denis Vlasenko <vda@ilport.com.ua>
> 
> "Applied."  Happy now? :-)

Yes. Thanks Dave :)
--
vda
