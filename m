Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264158AbTEGSML (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 14:12:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264161AbTEGSML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 14:12:11 -0400
Received: from pop.gmx.de ([213.165.65.60]:806 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264158AbTEGSMJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 14:12:09 -0400
Message-Id: <5.2.0.9.2.20030507202455.02610e88@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 07 May 2003 20:28:59 +0200
To: linux-kernel@vger.kernel.org
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [RFC] 2.5.X semaphore starvation fix^H^H^Hwork-around
In-Reply-To: <5.2.0.9.2.20030507122702.00caf640@wen-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:00 PM 5/7/2003 +0200, Mike Galbraith wrote:
>If you try the attached...

don't.  The idea works, but the implementation is buggy.  Under extreme 
load, it'll croak.
(not that anyone was interested anyway)

         -Mike

