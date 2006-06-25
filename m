Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWFYLGz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWFYLGz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 07:06:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932357AbWFYLGz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 07:06:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:48554 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932354AbWFYLGz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 07:06:55 -0400
Date: Sun, 25 Jun 2006 04:06:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Bugme-new] [Bug 6745] New: kernel hangs when trying to read  
 atip wiith cdrecord
Message-Id: <20060625040642.f37646ba.akpm@osdl.org>
In-Reply-To: <449E6B43.nail9A11I1BV@burner>
References: <449E6B43.nail9A11I1BV@burner>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Jun 2006 12:53:55 +0200
Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:

> The problem mentioned in this thread seems to be caused by the fact that
> Linux sometimes ignores timeouts. I have no idea how to help in this (timeout) 
> case.

OK, thanks.  So is that likely to be an IDE bug, or a SCSI bug or an IDE-CD
bug?

