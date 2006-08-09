Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030440AbWHIDjR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030440AbWHIDjR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 23:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030441AbWHIDjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 23:39:17 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:37461 "EHLO
	asav05.manage.insightbb.com") by vger.kernel.org with ESMTP
	id S1030440AbWHIDjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 23:39:16 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Aa4HAJP02ESBUQ
From: Dmitry Torokhov <dtor@insightbb.com>
To: cjacker huang <cjacker@gmail.com>
Subject: Re: [PATCH]Amoi laptop touchpad detection problem, should be in i8042 NOMUX blacklist.
Date: Tue, 8 Aug 2006 23:39:12 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <bde732200608072141g747bd814mb16b0a172738329d@mail.gmail.com>
In-Reply-To: <bde732200608072141g747bd814mb16b0a172738329d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608082339.12965.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 August 2006 00:41, cjacker huang wrote:
> Recently, I had test Red Flag Linux on an AMOI laptop(AMOI is PC
> vendor in China), found that the alps touchpad on this laptop can not
> be recognized automatically. after added the i8042.nomux to the kernel
> options, the touchpad works.
> 
> So I made this patch, maybe somebody need this.
>

Applied, thank you.

-- 
Dmitry
