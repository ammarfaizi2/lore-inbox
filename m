Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTFKUH4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 16:07:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264363AbTFKUH4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 16:07:56 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:29430 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264312AbTFKUHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 16:07:53 -0400
Date: Wed, 11 Jun 2003 13:17:42 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Joseph Fannin" <jhf@rivenstone.net>
Cc: linux-kernel@vger.kernel.org, vojtech@suse.cz, jhf@rivenstone.net,
       petero2@telia.com
Subject: Re: [PATCH] Synaptics TouchPad driver for 2.5.70
Message-Id: <20030611131742.3b057c93.akpm@digeo.com>
In-Reply-To: <m2u1axk0kp.fsf@p4.localdomain>
References: <m2u1axk0kp.fsf@p4.localdomain>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Jun 2003 20:21:36.0433 (UTC) FILETIME=[0EC11A10:01C33057]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Joseph Fannin" <jhf@rivenstone.net> wrote:
>
> Here is a driver for the Synaptics TouchPad for 2.5.70.

The code looks nice.

> +#include "synaptics.c"

But why on earth do we need to do this?


