Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVAIQcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVAIQcr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 11:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261589AbVAIQcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 11:32:47 -0500
Received: from fyrebird.net ([217.70.144.192]:61920 "HELO fyrebird.net")
	by vger.kernel.org with SMTP id S261585AbVAIQcp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 11:32:45 -0500
X-Qmail-Scanner-Mail-From: lethalman@fyrebird.net via fyrebird.net
X-Qmail-Scanner: 1.23 (Clear:RC:0(62.11.81.193):. Processed in 1.863295 secs)
Message-ID: <41E15A06.4040607@fyrebird.net>
Date: Sun, 09 Jan 2005 17:21:26 +0100
From: Lethalman <lethalman@fyrebird.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: patch to uselib()
References: <003f01c4f65e$9e4f91b0$b0e0a7c8@rootcon4qag3k5> <41E15413.7030509@fyrebird.net>
In-Reply-To: <41E15413.7030509@fyrebird.net>
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Breno Silva Pinto wrote:
> 
> Hi all,
>
> Is there a patch to uselib() bug ->
> http://www.isec.pl/vulnerabilities/isec-0021-uselib.txt ?
>
> Thanks
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

This one is for 2.4.28 and it's very very very simple:
http://lethalman.iosn.it/patches/uselib-2.4.28.patch

-- 
www.iosn.it * Amministratore Italian Open Source Network
www.fyrebird.net * Fyrebird Hosting Provider - Technical Department
