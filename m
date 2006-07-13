Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751524AbWGMLnd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751524AbWGMLnd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 07:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbWGMLnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 07:43:33 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:37545 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751524AbWGMLnc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 07:43:32 -0400
Date: Thu, 13 Jul 2006 13:43:19 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC] Move NTP related code to ntp.c
In-Reply-To: <1152749914.11963.33.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0607131323090.12900@scrub.home>
References: <1152749914.11963.33.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 12 Jul 2006, john stultz wrote:

> Roman: I know you had some larger NTP changes (getting rid of
> update_ntp_one_tick() for second-interval adjustments, etc). Are they
> still around?

I updated them and currently test them, so please hold back with larger 
reformating changes, otherwise the patch looks fine.

bye, Roman
