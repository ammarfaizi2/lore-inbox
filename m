Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261595AbTKXUuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 15:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbTKXUuE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 15:50:04 -0500
Received: from roc-24-169-2-225.rochester.rr.com ([24.169.2.225]:32896 "EHLO
	death.krwtech.com") by vger.kernel.org with ESMTP id S261595AbTKXUuC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 15:50:02 -0500
Date: Mon, 24 Nov 2003 15:49:59 -0500 (EST)
From: Ken Witherow <ken@krwtech.com>
X-X-Sender: ken@death
Reply-To: Ken Witherow <ken@krwtech.com>
To: Burton Windle <bwindle@fint.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: aic7xxx loading oops in 2.6.0-test10
In-Reply-To: <Pine.LNX.4.58.0311241524310.1245@morpheus>
Message-ID: <Pine.LNX.4.58.0311241549110.758@death>
References: <200311241736.23824.jlell@JakobLell.de> <Pine.LNX.4.53.0311241205500.18425@chaos>
 <20031124173527.GA1561@mail.shareable.org> <1069700224.459.60.camel@hosts>
 <Pine.LNX.4.58.0311241457330.575@death> <Pine.LNX.4.58.0311241524310.1245@morpheus>
Organization: KRW Technologies
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Nov 2003, Burton Windle wrote:

> http://marc.theaimsgroup.com/?l=linux-scsi&m=106965748506343&w=2
>
> This one-liner fixed my hang-on-boot with my AIC7880.

This patch does indeed fix the hang for me


-- 
       Ken Witherow <phantoml AT rochester.rr.com>
           ICQ: 21840670  AIM: phantomlordken
               http://www.krwtech.com/ken

