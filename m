Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263100AbTDBSo1>; Wed, 2 Apr 2003 13:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263117AbTDBSo0>; Wed, 2 Apr 2003 13:44:26 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:21509 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S263100AbTDBSo0>; Wed, 2 Apr 2003 13:44:26 -0500
Subject: Re: module.c broken in latest snapshot
From: James Bottomley <James.Bottomley@steeleye.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Brian Gerst <bgerst@didntduck.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0304021138570.8411-100000@chaos.physics.uiowa.edu>
References: <Pine.LNX.4.44.0304021138570.8411-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 02 Apr 2003 12:52:33 -0600
Message-Id: <1049309553.4111.14.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-04-02 at 11:41, Kai Germaschewski wrote:
> This patch should fix this problem and another, less obvious, one, which 
> made symbols exported by modules not work.

The patch certainly fixes my SCSI module hierarchy problems.

Thanks,

James


