Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750773AbVKQMqj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbVKQMqj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 07:46:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750777AbVKQMqj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 07:46:39 -0500
Received: from femail.waymark.net ([206.176.148.84]:61380 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S1750773AbVKQMqi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 07:46:38 -0500
Date: 17 Nov 2005 12:31:46 GMT
From: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Subject: Re: [2.6 patch] i386: always use 4k stacks
To: linux-kernel@vger.kernel.org
Message-ID: <b03b13.7133f7@familynet-international.net>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> In article 17 Nov 05, 06:17ish -0600 Kenneth Parrish wrote to All <=-

 AB> If one function calls another function you have to add the stack
 AB> usages.

[..]
> 78.5% of 493 make checkstack lines here report fewer than 200 bytes.
> Only six over 600.
Only six over 604. :)

--- MultiMail/Linux v0.46
