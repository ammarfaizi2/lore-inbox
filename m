Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265007AbUFVQIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265007AbUFVQIm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 12:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265009AbUFVQIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 12:08:12 -0400
Received: from s1-p135.svorka.net ([194.19.72.135]:13956 "EHLO
	mandrake.eldiablo.tk") by vger.kernel.org with ESMTP
	id S264973AbUFVQFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 12:05:38 -0400
Message-ID: <40D858D0.6080803@svorka.net>
Date: Tue, 22 Jun 2004 18:05:36 +0200
From: =?ISO-8859-1?Q?Espen_Fjellv=E6r_Olsen?= <eldiablo@svorka.net>
Reply-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040612)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: What Schedulers give best performance?]
References: <40D851BA.1050305@svorka.net>
In-Reply-To: <40D851BA.1050305@svorka.net>
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Espen Fjellvær Olsen wrote:

> In the recent past, there has been released many new types of both 
> disk and cpu schedulers, i wonder wich of them i should use to get best
> performance on my desktop system?
> Nickshed v30g, or maybe staircase 7.1, or spa, hudra, hybrid and so on,
> those are all quite new IO schedulers.
> Also there has been som new releases of the CFQ cpu scheduler, and som
> addons to this, cfq-ionice and so on.
>
> What scheduler combination do you use?
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


It should be the other way round, don't know why i called CFQ an cpu 
scheduler and nickshed a disk scheduler.
Must have had an hard day at work ;)
