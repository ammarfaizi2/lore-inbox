Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751292AbWFNPDK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbWFNPDK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 11:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751287AbWFNPDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 11:03:10 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:29906 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751292AbWFNPDI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 11:03:08 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: loop devices removable
To: Pablo Barbachano <pablobarbachano@yahoo.es>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Wed, 14 Jun 2006 17:02:10 +0200
References: <6nDUZ-4vk-17@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1FqWt5-0001Ro-8q@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pablo Barbachano <pablobarbachano@yahoo.es> wrote:

[loop devices]

> The (probably broken) reason I want to do that is so I can use (my
> modified) pmount to mount them.

I'm wondering if fuse would be suited better. I did not yet experiment
with that, but it seems it has everything you need.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
