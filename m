Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262902AbUFRUYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262902AbUFRUYy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 16:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266605AbUFRUVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:21:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:54720 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266799AbUFRUUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:20:41 -0400
Date: Fri, 18 Jun 2004 13:19:49 -0700
From: "David S. Miller" <davem@redhat.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: zwane@fsmlabs.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH][2.6] fix bridge sysfs improperly initialised knobject
Message-Id: <20040618131949.1ea95d68.davem@redhat.com>
In-Reply-To: <20040617144522.04ae5de7@dell_ss3.pdx.osdl.net>
References: <Pine.LNX.4.58.0406161247140.1944@montezuma.fsmlabs.com>
	<20040617144522.04ae5de7@dell_ss3.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004 14:45:22 -0700
Stephen Hemminger <shemminger@osdl.org> wrote:

> The whole effort to avoid hotplug was misguided.  If it is really a problem
> (which it doesn't appear to be) then it can more easily be addressed by smarter
> hotplug scripts in user space.
> 
> This patch gets rid of the whole subsystem hack for bridge kobjects.

Applied.
