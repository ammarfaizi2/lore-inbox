Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262674AbTLDQaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 11:30:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTLDQaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 11:30:13 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:64669 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S262674AbTLDQaL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 11:30:11 -0500
Message-ID: <3FCF62F1.5050109@pacbell.net>
Date: Thu, 04 Dec 2003 08:38:09 -0800
From: David Brownell <david-b@pacbell.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: Fredrik Tolf <fredrik@dolda2000.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Why is hotplug a kernel helper?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Btw., Is there any preferred method of announcing hotplug events to
> user interfaces?

There's interest in using D-BUS, but I'm not sure how it's progressed.
Which user's interface did you have in mind?  The relevant user may
be remote ... heck, they could even be a robot!  :)

- Dave


