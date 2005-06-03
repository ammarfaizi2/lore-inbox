Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261206AbVFCKTD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261206AbVFCKTD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 06:19:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261208AbVFCKTD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 06:19:03 -0400
Received: from gw.alcove.fr ([81.80.245.157]:15085 "EHLO smtp.fr.alcove.com")
	by vger.kernel.org with ESMTP id S261206AbVFCKTA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 06:19:00 -0400
Subject: Re: Sonypi: make sure that input_work is not running when unloading
From: Stelian Pop <stelian@popies.net>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: akpm@osdl.org, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200506030202.36140.dtor_core@ameritech.net>
References: <200506030202.36140.dtor_core@ameritech.net>
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jun 2005 12:11:40 +0200
Message-Id: <1117793500.4171.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 03 juin 2005 à 02:02 -0500, Dmitry Torokhov a écrit :

> Sonypi: make sure that input_work is not running when unloading
>         the module; submit/retrieve key release data into/from
>         input_fifo in one shot.
> 
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

Acked-by: Stelian Pop <stelian@popies.net>

Thanks Dmitry.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

