Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbTFIU7o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jun 2003 16:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262093AbTFIU7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jun 2003 16:59:44 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:47634 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP id S262073AbTFIU7l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jun 2003 16:59:41 -0400
Date: Mon, 09 Jun 2003 15:13:18 +0000
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Dan Kegel <dank@kegel.com>, linux-kernel@vger.kernel.org
Subject: Re: huge file drivers/scsi/aic78xx/CHANGELOG in 2.4.21-rc7?
Message-ID: <14350000.1055171597@caspian.scsiguy.com>
In-Reply-To: <3EE2D38B.5000006@kegel.com>
References: <3EE2D38B.5000006@kegel.com>
X-Mailer: Mulberry/3.0.3 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Saturday, June 07, 2003 23:11:23 -0700 Dan Kegel <dank@kegel.com> wrote:

> Do we really need 23000 lines of "perforce describe" output
> in the kernel source tree?

The CHANGELOG has never been in the BK files that I submit.  My guess
is that when the driver was last updated, the CHANGELOG file from the
tar distribution was included.  I don't think it should be especially
if the BK files are used for the next update.  In my merges with 2.4.X,
I have maintained file history even when duplicate changes were integrated
via "patch" instead of via BK.

--
Justin

