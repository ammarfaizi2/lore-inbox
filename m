Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264697AbUFGOgo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264697AbUFGOgo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 10:36:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264693AbUFGOgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 10:36:44 -0400
Received: from webapps.arcom.com ([194.200.159.168]:8972 "EHLO
	webapps.arcom.com") by vger.kernel.org with ESMTP id S264702AbUFGOgj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 10:36:39 -0400
Message-ID: <40C47D73.4000001@arcom.com>
Date: Mon, 07 Jun 2004 15:36:35 +0100
From: David Vrabel <dvrabel@arcom.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Wichert Akkerman <wichert@wiggy.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: kbuild make deb patch
References: <20040607141353.GK21794@wiggy.net>
In-Reply-To: <20040607141353.GK21794@wiggy.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Jun 2004 14:44:12.0953 (UTC) FILETIME=[E63CB090:01C44C9D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wichert Akkerman wrote:
> 
> kbuild has had a rpm make target for some time now. Since the concept of
> kernel packages is quite convenient I added a deb target as well,

Why this and not the make-kpkg utility in Debian's kernel-package package?

David Vrabel
-- 
David Vrabel, Design Engineer

Arcom, Clifton Road           Tel: +44 (0)1223 411200 ext. 3233
Cambridge CB1 7EA, UK         Web: http://www.arcom.com/
