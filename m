Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267059AbSLDUEU>; Wed, 4 Dec 2002 15:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267062AbSLDUEU>; Wed, 4 Dec 2002 15:04:20 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:55954 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267059AbSLDUEU>; Wed, 4 Dec 2002 15:04:20 -0500
Date: Wed, 4 Dec 2002 21:11:38 +0100
From: Andi Kleen <ak@muc.de>
To: Roland Dreier <roland@topspin.com>
Cc: ak@muc.de, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org,
       davem@redhat.com
Subject: Re: rtnetlink replacement for SIOCSIFHWADDR
Message-ID: <20021204201138.GA29792@averell>
References: <52wumpbpql.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52wumpbpql.fsf@topspin.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Or, we could add a new RTM_SETLINK message that userspace can send
>   to the kernel to modify an interface's properties.

Defining a RTM_SETLINK would seem to be cleanest to me.

-Andi
