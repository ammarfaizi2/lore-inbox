Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUCQR7v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 12:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbUCQR7v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 12:59:51 -0500
Received: from web60705.mail.yahoo.com ([216.109.117.228]:12458 "HELO
	web60705.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261162AbUCQR7t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 12:59:49 -0500
Message-ID: <20040317175939.75460.qmail@web60705.mail.yahoo.com>
Date: Wed, 17 Mar 2004 09:59:39 -0800 (PST)
From: VINOD GOPAL <vinod_gopal74@yahoo.com>
Subject: arithmetic functions for linux driver
To: linux-kernel@vger.kernel.org
In-Reply-To: <4825B7F5-783A-11D8-97E9-000A95CFFC9C@idtect.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 I am new to linux world and this mailing list.

 I need to use the arithmetic functions like sin, cos,
exp, log, etc in linux device driver.

 On search read , not to use libm from kernel driver
as it will harm the fpu registers.
  
  Do you have any insight how to support these
functions in linux driver or any code that is
available which I can make use of?

thanks
vinod

__________________________________
Do you Yahoo!?
Yahoo! Mail - More reliable, more storage, less spam
http://mail.yahoo.com
