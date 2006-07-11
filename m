Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750841AbWGKTAe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750841AbWGKTAe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWGKTAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:00:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:8876 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750841AbWGKTAd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:00:33 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=opfEehkv6u48+FHpI9vDeswSsCZBGsU5rXw9PdT1ZofP89YoialadrFusUcUL501LAzuHdIMlaC4k1VlKHfGCaBN7clsfLuni1HPwRd+8tjaUMMH4BJDsVFBoh/qqjvnDnW0DsH3NMDVwB6Bll87rIaoMtqy6GosPnjLeiNR1pI=
Message-ID: <a762e240607111200v743bb598pa9717ce3087bfd51@mail.gmail.com>
Date: Tue, 11 Jul 2006 12:00:31 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc1-mm1 panic on boot x86_64 NMI watchdog detected LOCKUP
Cc: "Andrew Morton" <akpm@osdl.org>
In-Reply-To: <a762e240607111125y1f9a67eleadbd1fffd053be6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a762e240607111112v1bd28135hf99fdf0cc08a6d52@mail.gmail.com>
	 <a762e240607111125y1f9a67eleadbd1fffd053be6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also just tested 2.6.18-rc1 and it booted just fine with same basic
config. Must be something in -mm.

Keith
