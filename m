Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288283AbSAMXNw>; Sun, 13 Jan 2002 18:13:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288284AbSAMXNm>; Sun, 13 Jan 2002 18:13:42 -0500
Received: from femail1.sdc1.sfba.home.com ([24.0.95.81]:53985 "EHLO
	femail1.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S288283AbSAMXN1>; Sun, 13 Jan 2002 18:13:27 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] Intelligible build process v0.02
Date: Sun, 13 Jan 2002 10:11:25 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <20020113222957.GKGI8076.femail23.sdc1.sfba.home.com@there>
In-Reply-To: <20020113222957.GKGI8076.femail23.sdc1.sfba.home.com@there>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020113231326.WSDD27139.femail1.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 January 2002 09:27 am, Rob Landley wrote:

> The previous version got really confused by what "make dep" did in response
> to kernel module versions being switched on (but only after a fresh untar,
> or after running make mrproper).

I forgot to thank Randolph Bentson for finding that, by the way...

Rob
