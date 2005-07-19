Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261886AbVGSB7U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261886AbVGSB7U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 21:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261917AbVGSB7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 21:59:20 -0400
Received: from femail.waymark.net ([206.176.148.84]:11404 "EHLO
	femail.waymark.net") by vger.kernel.org with ESMTP id S261886AbVGSB7S convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 21:59:18 -0400
Date: 19 Jul 2005 01:58:18 GMT
From: Kenneth Parrish <Kenneth.Parrish@family-bbs.org>
Subject: Re: 2.6.12-rc2 and as-iosched
To: linux-kernel@vger.kernel.org
In-Reply-To: <20050718134933.GA1890@suse.de>
Message-ID: <603f9d.f2a749@family-bbs.org>
Organization: FamilyNet HQ
X-Mailer: BBBS/NT v4.01 Flag-5
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-=> axboe@suse.de wrote to Kenneth Parrish <=-

 ax> ok, AS is definitely broken, it does an internal HZ <-> msec
 ax> conversion in the store/show functions as well. This should fix
 ax> it.
thank ya   :-)
