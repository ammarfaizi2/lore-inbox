Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932363AbVKLMCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932363AbVKLMCn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 07:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932361AbVKLMCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 07:02:43 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:19374 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932363AbVKLMCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 07:02:43 -0500
From: Denis Vlasenko <vda@ilport.com.ua>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] drivers/net/wireless/tiacx/: add missing #include <linux/vmalloc.h>'a
Date: Sat, 12 Nov 2005 14:02:01 +0200
User-Agent: KMail/1.8.2
Cc: jgarzik@pobox.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20051111200735.GO5376@stusta.de>
In-Reply-To: <20051111200735.GO5376@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511121402.01465.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 November 2005 22:07, Adrian Bunk wrote:
> This is required for always getting the vmalloc()/vfree() prototypes.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Applied, thanks.
--
vda
