Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTFPIdT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 04:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263610AbTFPIdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 04:33:19 -0400
Received: from 213-187-164-3.dd.nextgentel.com ([213.187.164.3]:22443 "EHLO
	exchange.Pronto.TV") by vger.kernel.org with ESMTP id S263590AbTFPIdS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 04:33:18 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: [PATCH] O_DIRECT for ext3 (2.4.21)
Date: Mon, 16 Jun 2003 10:47:10 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20030615110106.GA8404@karlsbakk.net> <20030615113227.GS28900@mea-ext.zmailer.org>
In-Reply-To: <20030615113227.GS28900@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306161047.10158.roy@karlsbakk.net>
X-OriginalArrivalTime: 16 Jun 2003 08:47:10.0779 (UTC) FILETIME=[E02798B0:01C333E3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 15 June 2003 13:32, Matti Aarnio wrote:
>   There is O_DIRECT support for ext3  in 2.5.
>   How does this relate to that 2.5 version ?

I don't know.  Someone (sorry - don't remember who) sent me this patch, and it 
works fine with my application (which is video streaming). Anyway - we need 
O_DIRECT for ext3 somehow, and it should've been there already for ext3, IMHO
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

