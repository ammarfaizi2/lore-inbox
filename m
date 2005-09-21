Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbVIUN2D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbVIUN2D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 09:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbVIUN2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 09:28:03 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:33678 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S1750901AbVIUN2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 09:28:01 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Robert.Boermans@uk.telex.com
Subject: Re:
Date: Wed, 21 Sep 2005 16:27:12 +0300
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <OFC881AE81.2A41D9FD-ON80257083.00491CF1-80257083.00494354@telex.com>
In-Reply-To: <OFC881AE81.2A41D9FD-ON80257083.00491CF1-80257083.00494354@telex.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509211627.12154.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 21 September 2005 16:20, Robert.Boermans@uk.telex.com wrote:
> Hello, 
> 
> I noticed that the bogomips results for the two cores on my machine are 
> consistently not the same, the second one is always reported slightly 
> faster, it's a small difference and I saw the same in a posted dmesg from 
> somebody else on the list. Which made me wonder: 

I guess it's a cache warming effect. Please show the numbers.
--
vda
