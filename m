Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265673AbUBFXAw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:00:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265686AbUBFXAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:00:52 -0500
Received: from mx1.mail.ru ([194.67.23.21]:11537 "EHLO mx1.mail.ru")
	by vger.kernel.org with ESMTP id S265673AbUBFXAo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:00:44 -0500
Message-ID: <40241C96.6010602@mail.ru>
Date: Sat, 07 Feb 2004 00:00:38 +0100
From: marcel cotta <mc123@mail.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
Followup-To: marcel,cotta,<mc123@mail.ru>
To: linux-kernel@vger.kernel.org
CC: Nick Piggin <piggin@cyberone.com.au>
Subject: Re: VM patches (please review)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam: Not detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hey nick

these patches are working great for me (k7-2400+,256mb ram)

whenever about 100M of swap were in use, the system was
nearly unusable when i switched to another app under X

with your patches i got interactivity back and it nearly feals like 2.4

thanks :)
