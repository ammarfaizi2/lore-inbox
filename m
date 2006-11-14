Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966196AbWKNRpW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966196AbWKNRpW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 12:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966197AbWKNRpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 12:45:21 -0500
Received: from sd291.sivit.org ([194.146.225.122]:32785 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S966196AbWKNRpU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 12:45:20 -0500
Subject: Re: [PATCH] appletouch: use canonical names instead of raw USB IDs
From: Stelian Pop <stelian@popies.net>
To: Julien BLACHE <jb@jblache.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, dmitry.torokhov@gmail.com
In-Reply-To: <871wo6q6y1.fsf@frigate.technologeek.org>
References: <871wo6q6y1.fsf@frigate.technologeek.org>
Content-Type: text/plain; charset=ISO-8859-15
Date: Tue, 14 Nov 2006 18:45:12 +0100
Message-Id: <1163526312.28910.14.camel@deep-space-9.dsnet>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 14 novembre 2006 à 18:22 +0100, Julien BLACHE a écrit :
> Hi,
> 
> Small readability improvement for appletouch: use canonical names
> instead of raw USB IDs for some of the devices.

While you're at it, please update hid-core.c too for the FN_KEY quirks.

The same comments applies to your other patch which adds the new Geyser
IV ids. Those needs to be added to hid-core.c too.

Otherwise you have my
	Acked-by: Stelian Pop <stelian@popies.net>
for the both patches.

Oh, and put your patch in the mail inline, it's easier to quote if
needed.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

