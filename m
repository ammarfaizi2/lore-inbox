Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261826AbTDQSV1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 14:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbTDQSV1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 14:21:27 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2176 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S261826AbTDQSV0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 14:21:26 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304171836.h3HIaFIw000166@81-2-122-30.bradfords.org.uk>
Subject: Re: cannot boot 2.5.67
To: linuxnow@newtral.org (Pau Aliagas)
Date: Thu, 17 Apr 2003 19:36:15 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (lkml)
In-Reply-To: <Pine.LNX.4.44.0304171900490.1143-100000@pau.intranet.ct> from "Pau Aliagas" at Apr 17, 2003 07:03:21 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a rh9 installation, grub is properly configured, and when I select 
> to boot a 2.5 kernel it does not even decompress it. It stops even before 
> printing the kernel version.
> 
> What am I doing wrong?

Are you sure that Grub is configured correctly?  Have you tried older
2.5 kernels until you find one that works?

John.
