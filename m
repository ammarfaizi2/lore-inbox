Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261593AbTBEQRR>; Wed, 5 Feb 2003 11:17:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261594AbTBEQRR>; Wed, 5 Feb 2003 11:17:17 -0500
Received: from coffee.Psychology.mcmaster.ca ([130.113.218.59]:56999 "EHLO
	coffee.psychology.mcmaster.ca") by vger.kernel.org with ESMTP
	id <S261593AbTBEQRQ>; Wed, 5 Feb 2003 11:17:16 -0500
Date: Wed, 5 Feb 2003 11:26:34 -0500 (EST)
From: Mark Hahn <hahn@physics.mcmaster.ca>
X-X-Sender: hahn@coffee.psychology.mcmaster.ca
To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
cc: linux-security-module@wirex.com, <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH] LSM changes for 2.5.59
In-Reply-To: <200302051500.KAA05879@moss-shockers.ncsc.mil>
Message-ID: <Pine.LNX.4.44.0302051124230.4582-100000@coffee.psychology.mcmaster.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No.  If one were to add such a field, then it would be accessible
> through the ctl_table structure that is already passed to the hook.
> You would not replace the ctl_table parameter with the kernel's
> sensitivity hint, since the security module must be able to make its

can all this LSM nonsese be CONFIG'ed out of the kernel as promised?

