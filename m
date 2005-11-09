Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030777AbVKIVEB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030777AbVKIVEB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 16:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030779AbVKIVEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 16:04:01 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:60684 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1030777AbVKIVEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 16:04:00 -0500
To: drepper@redhat.com
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
In-reply-to: <43724AB3.40309@redhat.com> (message from Ulrich Drepper on Wed,
	09 Nov 2005 11:14:59 -0800)
Subject: Re: openat()
References: <43724AB3.40309@redhat.com>
Message-Id: <E1EZx6Q-0002zw-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 09 Nov 2005 22:03:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can we please get the openat() syscall implemented?

What's wrong with using '/proc/self/fd/N' to implement it?

Miklos
