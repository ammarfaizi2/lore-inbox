Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750930AbWAYQeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbWAYQeo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 11:34:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbWAYQeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 11:34:44 -0500
Received: from mail0.lsil.com ([147.145.40.20]:39344 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S1750899AbWAYQen convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 11:34:43 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: [2.6 patch] drivers/message/fusion/mptfc.c: make 2 functions static
Date: Wed, 25 Jan 2006 09:26:48 -0700
Message-ID: <F331B95B72AFFB4B87467BE1C8E9CF5F1FE9E0@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [2.6 patch] drivers/message/fusion/mptfc.c: make 2 functions static
Thread-Index: AcYhS1gw8FamJrRBRxKQEzLCV20kfwAgKGIg
From: "Moore, Eric" <Eric.Moore@lsil.com>
To: "Adrian Bunk" <bunk@stusta.de>, "Andrew Morton" <akpm@osdl.org>
Cc: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 25 Jan 2006 16:26:49.0186 (UTC) FILETIME=[24400C20:01C621CC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 24, 2006 6:01 PM, Adrian Bunk wrote:

> This patch makes two needlessly global functions static.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
> This patch was already sent on:
> - 19 Jan 2006
> 
>  drivers/message/fusion/mptfc.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 


ACK

Signed-off-by: Eric Moore <Eric.Moore@lsil.com>
