Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbUCELr1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 06:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbUCELr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 06:47:27 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2432 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S262550AbUCELrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 06:47:25 -0500
Date: Fri, 5 Mar 2004 11:47:09 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200403051147.i25Bl9VI000468@81-2-122-30.bradfords.org.uk>
To: Billy Rose <billyrose@cox-internet.com>, krishnakumar@naturesoft.net,
       Tim Bird <tim.bird@am.sony.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200403041858.45617.billyrose@cox-internet.com>
References: <200403022152.06950.billyrose@cox-internet.com>
 <40460C8E.4010100@am.sony.com>
 <200403040942.23176.krishnakumar@naturesoft.net>
 <200403041858.45617.billyrose@cox-internet.com>
Subject: Re: kernel mode console
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i think perhaps i need to expound upon what i have a vision of. a
> kernel mode console is just that: a console designed to run in
> kernel mode.

It could be quite useful for debugging heavily embedded systems where
you don't really have a 'standard' userspace.

John.
