Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264928AbSJVWFZ>; Tue, 22 Oct 2002 18:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264938AbSJVWFZ>; Tue, 22 Oct 2002 18:05:25 -0400
Received: from air-2.osdl.org ([65.172.181.6]:37011 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264928AbSJVWFY>;
	Tue, 22 Oct 2002 18:05:24 -0400
Subject: Re: Linux 2.5.44-ac1
From: Mark Haverkamp <markh@osdl.org>
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200210221727.g9MHR6128999@devserv.devel.redhat.com>
References: <200210221727.g9MHR6128999@devserv.devel.redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 22 Oct 2002 15:12:26 -0700
Message-Id: <1035324746.24190.3.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-10-22 at 10:27, Alan Cox wrote:

> o	Fix blk ioctls on aacraid			(Mark Haverkamp)

Somewhere between 2.5.43 and 2.5.44 the blk ioctls code changed
elsewhere making this one unnecessary.

Mark. 

