Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964817AbVLUUcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964817AbVLUUcn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 15:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbVLUUcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 15:32:43 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:18371
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932498AbVLUUcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 15:32:42 -0500
Date: Wed, 21 Dec 2005 12:31:51 -0800 (PST)
Message-Id: <20051221.123151.54314548.davem@davemloft.net>
To: jesper.juhl@gmail.com
Cc: jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org, bunk@stusta.de
Subject: Re: ip_output.c change question
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <9a8748490512211135lb2248bdm7c0c7e9a71398bbc@mail.gmail.com>
References: <Pine.LNX.4.61.0512212021140.12159@yvahk01.tjqt.qr>
	<9a8748490512211135lb2248bdm7c0c7e9a71398bbc@mail.gmail.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>
Date: Wed, 21 Dec 2005 20:35:22 +0100

> [Adding Adrian Bunk and David Miller to Cc as they both signed off on
> the patch, maybe they can explain]

Nothing inside the tree references that symbol.

The tarpit thing is an external netfilter module.
