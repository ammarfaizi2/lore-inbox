Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265264AbUAETg3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 14:36:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265300AbUAETg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 14:36:28 -0500
Received: from x35.xmailserver.org ([69.30.125.51]:7096 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S265264AbUAETeH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 14:34:07 -0500
X-AuthUser: davidel@xmailserver.org
Date: Mon, 5 Jan 2004 11:33:51 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: John Gardiner Myers <jgmyers@speakeasy.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch/revised] wake_up_info() ...
In-Reply-To: <3FF9BAD3.9040804@speakeasy.net>
Message-ID: <Pine.LNX.4.44.0401051133270.17134-100000@bigblue.dev.mdolabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Jan 2004, John Gardiner Myers wrote:

> It would seem better if info were a void *, to permit sending more than 
> a single unsigned long.

It's fine for me. Linus, Manfred?



- Davide


