Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130528AbRCIPYQ>; Fri, 9 Mar 2001 10:24:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130534AbRCIPYH>; Fri, 9 Mar 2001 10:24:07 -0500
Received: from cnxt19932001.conexant.com ([199.191.32.1]:31751 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S130528AbRCIPXy>; Fri, 9 Mar 2001 10:23:54 -0500
Date: Fri, 9 Mar 2001 16:22:45 +0100 (CET)
From: <rui.sousa@mindspeed.com>
To: "John O'Connor" <joconnor@orga.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: SMP and non-SMP modules
In-Reply-To: <3AA8DA1E.557C946C@orga.com>
Message-ID: <Pine.LNX.4.30.0103091606230.12607-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Mar 2001, John O'Connor wrote:

> What is the difference between an SMP and a non-SMP module?
>
> I have a module that works fine on 2.2.14 and I want to make it run on another distribution that uses a 2.2.16-SMP kernel.
>
> What changes will be needed?

You will need at least to recompile the module against the new kernel.

Rui Sousa

