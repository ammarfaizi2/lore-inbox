Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267063AbSKEDb2>; Mon, 4 Nov 2002 22:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276301AbSKEDb2>; Mon, 4 Nov 2002 22:31:28 -0500
Received: from ns.suse.de ([213.95.15.193]:29715 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267063AbSKEDb0> convert rfc822-to-8bit;
	Mon, 4 Nov 2002 22:31:26 -0500
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: What's left over.
Date: Tue, 5 Nov 2002 04:38:01 +0100
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <20021031030143.401DA2C150@lists.samba.org> <20021031031954.56C772C156@lists.samba.org> <20021031062118.GA18007@tapu.f00f.org>
In-Reply-To: <20021031062118.GA18007@tapu.f00f.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200211050438.01179.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 October 2002 07:21, Chris Wedgwood wrote:
> Don't get me wrong, I'm not against sane ACLs (POSIX ACLs are not) or
> EAs [...]

POSIX ACLs are more complicated than what would be inherently necessary, if we 
were in a situation where we could design from scratch. Unfortunately we are 
not in that situation. I've heard dozens of people complain about POSIX ACLs 
(and other kinds as well); nobody was able to come up with something truly 
better so far.

--Andreas.

