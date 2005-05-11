Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVEKJ5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVEKJ5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 05:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261955AbVEKJ5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 05:57:45 -0400
Received: from smtp1.wanadoo.fr ([193.252.22.30]:59011 "EHLO smtp1.wanadoo.fr")
	by vger.kernel.org with ESMTP id S261948AbVEKJ5n convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 05:57:43 -0400
X-ME-UUID: 20050511095742679.A5E5E1C001B1@mwinf0109.wanadoo.fr
Subject: Re: [patch 2.6.12-rc3] dell_rbu: New Dell BIOS update driver
From: Xavier Bestel <xavier.bestel@free.fr>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       matt_domsch@dell.com
In-Reply-To: <20050510220520.GA30741@littleblue.us.dell.com>
References: <20050510220520.GA30741@littleblue.us.dell.com>
Content-Type: text/plain; charset=utf-8
Date: Wed, 11 May 2005 11:57:20 +0200
Message-Id: <1115805441.11819.175.camel@gonzales>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 10 mai 2005 à 17:05 -0500, Abhay Salunke a écrit :

> +2> Download the BIOS image by copying the image file to /sys/firmware/rbudata 
> +file.
> +e.g. echo image.hdr > /sys/firmware/rbudata

Don't you mean 'cat' instead of 'echo' there ?

	Xav


