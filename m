Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266140AbUF2XW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266140AbUF2XW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 19:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266139AbUF2XW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 19:22:57 -0400
Received: from winds.org ([68.75.195.9]:41877 "EHLO winds.org")
	by vger.kernel.org with ESMTP id S266078AbUF2XWo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 19:22:44 -0400
Date: Tue, 29 Jun 2004 19:22:37 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
cc: Mark Haverkamp <markh@osdl.org>, Alan Cox <alan@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-scsi <linux-scsi@vger.kernel.org>
Subject: RE: PATCH: Further aacraid work
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189FF1D6EE@otce2k03.adaptec.com>
Message-ID: <Pine.LNX.4.60.0406291918590.27755@winds.org>
References: <547AF3BD0F3F0B4CBDC379BAC7E4189FF1D6EE@otce2k03.adaptec.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2004, Salyzyn, Mark wrote:

> Oooo, good!
>
> The Adapter has declared itself `dead' (maybe for reasons other than a
> controlled blinkLED situation). Effectively a crash or complete loss of
> communications with the Adapter. Last time I've seen this happened it
> was a bad power supply.
>
> Contact technical support to have them narrow down the actual cause of
> adapter failure ... I don't know where the F/W updates are held on the
> Dell Site.

I found the firmware updates on Dell's site, latest version 2.8.0, build 6089.
I'm going to try updating the server along with its BIOS tomorrow morning.

I'll keep you posted!

  -Byron

--
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com
