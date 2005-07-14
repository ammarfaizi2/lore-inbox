Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262999AbVGNJ6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262999AbVGNJ6P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 05:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263000AbVGNJ6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 05:58:15 -0400
Received: from webapps.arcom.com ([194.200.159.168]:28432 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S262998AbVGNJ6K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 05:58:10 -0400
Message-ID: <42D6372E.1020201@cantab.net>
Date: Thu, 14 Jul 2005 10:58:06 +0100
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chuck Ebbert <76306.1226@compuserve.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc2-mm2
References: <200507131733_MC3-1-A464-F432@compuserve.com>
In-Reply-To: <200507131733_MC3-1-A464-F432@compuserve.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jul 2005 10:08:57.0406 (UTC) FILETIME=[0C43B5E0:01C5885C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Ebbert wrote:
>    Looks like Quilt is adding the space during push/pop operations.  Only the
> lines it has touched in the series file have the trailing space.

Quilt versions prior to 0.39 would add a trailing space to the series
file entry when doing a quilt refresh with the default -p1 patch level.

David Vrabel
