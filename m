Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936175AbWK3DRU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936175AbWK3DRU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 22:17:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936178AbWK3DRU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 22:17:20 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:63454 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S936175AbWK3DRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 22:17:19 -0500
Date: Wed, 29 Nov 2006 19:17:36 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: linux-kernel@vger.kernel.org (linux-kernel)
Subject: Re: 2.6.19 panic on boot -- i386
Message-Id: <20061129191736.9c50d61e.randy.dunlap@oracle.com>
In-Reply-To: <200611300313.kAU3D9J7007005@clem.clem-digital.net>
References: <200611300313.kAU3D9J7007005@clem.clem-digital.net>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006 22:13:09 -0500 (EST) Pete Clements wrote:

> 2.6.19 panics at boot. Good up through rc6-git11.
> Hand copied screen below.

Try the patch that DaveM recently posted:
  http://lkml.org/lkml/2006/11/29/335

---
~Randy
