Return-Path: <linux-kernel-owner+w=401wt.eu-S964976AbWLMNP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWLMNP2 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 08:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWLMNPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 08:15:19 -0500
Received: from smtp.nokia.com ([131.228.20.172]:60764 "EHLO
	mgw-ext13.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964973AbWLMNPP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 08:15:15 -0500
Subject: Re: 2.6.19-mm1: missing MTD_UBI* help texts
From: Artem Bityutskiy <dedekind@infradead.org>
Reply-To: dedekind@infradead.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mtd@lists.infradead.org
In-Reply-To: <20061211164225.GO10351@stusta.de>
References: <20061211005807.f220b81c.akpm@osdl.org>
	 <20061211164225.GO10351@stusta.de>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Dec 2006 14:37:56 +0200
Message-Id: <1166013476.16396.17.camel@sauron>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 13 Dec 2006 12:37:57.0054 (UTC) FILETIME=[84467DE0:01C71EB3]
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-11 at 17:42 +0100, Adrian Bunk wrote:
> The MTD_UBI and the MTD_UBI_DEBUG_PARANOID_* options lack help texts.

thanks, fixed in our GIT tree.

-- 
Best regards,
Artem Bityutskiy (Битюцкий Артём)

