Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423269AbWJaNtF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423269AbWJaNtF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 08:49:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423270AbWJaNtF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 08:49:05 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:34315 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1423269AbWJaNtC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 08:49:02 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend to disk:  do we HAVE to use swap?
Date: Tue, 31 Oct 2006 13:48:59 +0000
User-Agent: KMail/1.9.5
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
References: <4546C637.5080504@comcast.net> <200610310716.40181.rjw@sisk.pl>
In-Reply-To: <200610310716.40181.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610311348.59069.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 October 2006 06:16, Rafael J. Wysocki wrote:
[snip]
> However, we already have code that allows us to use swap files for the
> suspend and turning a regular file into a swap file is as easy as running
> 'mkswap' and 'swapon' on it.

How is this feature enabled? I don't see it in 2.6.19-rc4.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
