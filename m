Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265528AbTIJTB6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265529AbTIJTBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:01:54 -0400
Received: from fw.osdl.org ([65.172.181.6]:46278 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265528AbTIJTBj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:01:39 -0400
Date: Wed, 10 Sep 2003 11:43:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
Message-Id: <20030910114346.025fdb59.akpm@osdl.org>
In-Reply-To: <20030910185537.GB1461@matchmail.com>
References: <20030828235649.61074690.akpm@osdl.org>
	<20030910185338.GA1461@matchmail.com>
	<20030910185537.GB1461@matchmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> I have another oops for you with 2.6.0-test4-mm3-1 and ide-scsi. 

ide-scsi is a dead duck.  defunct.  kaput.  Don't use it.  It's only being
kept around for weirdo things like IDE-based tape drives, scanners, etc.

Just use /dev/hdX directly.

