Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932510AbWBXVZp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbWBXVZp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 16:25:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932521AbWBXVZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 16:25:45 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:44218 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S932510AbWBXVZo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 16:25:44 -0500
Message-ID: <43FF79CE.8050800@zabbo.net>
Date: Fri, 24 Feb 2006 13:25:34 -0800
From: Zach Brown <zab@zabbo.net>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] maestro3 vfree NULL check fixup
References: <200602242148.27855.jesper.juhl@gmail.com> <200602242217.21180.jesper.juhl@gmail.com> <9a8748490602241318y69966ce6yc0907e89af559978@mail.gmail.com> <200602242222.31659.jesper.juhl@gmail.com>
In-Reply-To: <200602242222.31659.jesper.juhl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Don't check pointers for NULL before calling vfree and get rid
> of a pointless helper function in sound/oss/maestro3.c

Nice work, thanks.

Acked-by: Zach Brown <zab@zabbo.net>
