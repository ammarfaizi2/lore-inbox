Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267263AbTAKPsz>; Sat, 11 Jan 2003 10:48:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267264AbTAKPsy>; Sat, 11 Jan 2003 10:48:54 -0500
Received: from [66.70.28.20] ([66.70.28.20]:56328 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S267263AbTAKPsy>; Sat, 11 Jan 2003 10:48:54 -0500
Date: Sat, 11 Jan 2003 14:27:21 +0100
From: DervishD <raul@pleyades.net>
To: Bob <gillb4@telusplanet.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Partition full BUG?
Message-ID: <20030111132721.GA67@DervishD>
References: <1042275265.24317.63.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1042275265.24317.63.camel@localhost.localdomain>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Bob :)

> can't contain all of the data appended to it, the whole file is
> truncated to zero bytes (only the filename remains).  Is that supposed
> to happen?

    Does that happen with *any* program? I don't think so. It's more
probable that the bug is into your editor, not into the kernel ;))
Try to fill a filesystem using 'dd' or something like that.

    Raúl
