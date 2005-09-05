Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbVIECHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbVIECHh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 22:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbVIECHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 22:07:37 -0400
Received: from simmts12.bellnexxia.net ([206.47.199.141]:1947 "EHLO
	simmts12-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S932179AbVIECHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 22:07:37 -0400
Message-ID: <39271.10.10.10.10.1125886053.squirrel@linux1>
In-Reply-To: <20050905020027.15257.qmail@web50215.mail.yahoo.com>
References: <20050905020027.15257.qmail@web50215.mail.yahoo.com>
Date: Sun, 4 Sep 2005 22:07:33 -0400 (EDT)
Subject: re: RFC: i386: kill !4KSTACKS
From: "Sean" <seanlkml@sympatico.ca>
To: "Alex Davis" <alex14641@yahoo.com>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.4-2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, September 4, 2005 10:00 pm, Alex Davis said:
> Dave Jones wrote:
>>- NDISwrapper / driverloader.
>>  (Shock, horror - no-one cares).
>
> Shock, horror. Someone DOES care: everyone who uses ndiswrapper or
> driverloader, whether they know it or not. Are you proposing that
> we punish the end-users because of the obstinence of the hardware
> manufacturers? If/when native drivers are written, maybe we can
> revisit this.


Continuing the promotion of binary-only drivers _hurts_ the demand for
(and thus the development of) open source drivers.  Read the comment from
Dave as something like "Nobody who matters, with regard to kernel
development, cares about NDISwrapper".   If _you_ care, fork your own tree
and maintain the patch as necessary.

Regards,
Sean

