Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262329AbSJHL2Q>; Tue, 8 Oct 2002 07:28:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262343AbSJHL2Q>; Tue, 8 Oct 2002 07:28:16 -0400
Received: from 62-190-217-19.pdu.pipex.net ([62.190.217.19]:59909 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S262329AbSJHL2P>; Tue, 8 Oct 2002 07:28:15 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210081111.g98BBFfv010140@darkstar.example.net>
Subject: Re: The end of embedded Linux?
To: simon@baydel.com
Date: Tue, 8 Oct 2002 12:11:14 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <3DA2BD70.14919.2C6951@localhost> from "simon@baydel.com" at Oct 08, 2002 11:11:44 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> These modules again drive gate array hardware for which nobody 
> else will ever have a compatible. Although I would dearly love to 
> use Linux as the platform for my project I feel I cannot release this 
> code under the GPL.

That just doesn't make sense.  If nobody else will ever have a
compatible piece of hardware, I don't see why you wouldn't want to
release the driver code under the GPL.

_Unless_ you fear that somebody will derive your hardware design from
the code.  Is that what you're worried about?

John.
