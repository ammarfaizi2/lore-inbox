Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262011AbVBPNCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262011AbVBPNCn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 08:02:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbVBPNCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 08:02:42 -0500
Received: from chewbacca.hagos.de ([213.217.124.234]:61106 "EHLO mail.hagos.de")
	by vger.kernel.org with ESMTP id S262011AbVBPNCl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 08:02:41 -0500
From: Klaus Muth <muth@hagos.de>
Organization: HAGOS eG
To: Jonathan Sambrook <jonathan@dsvr.net>
Subject: Re: kernel panic with 2.4.26
Date: Wed, 16 Feb 2005 14:02:33 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200501210715.03716.muth@hagos.de> <200502111015.54681.muth@hagos.de> <42132B31.7010503@dsvr.net>
In-Reply-To: <42132B31.7010503@dsvr.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502161402.33666.muth@hagos.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 16. Februar 2005 12:14 schrieb Jonathan Sambrook:
> >>Every now and then (maybe twice a week) my server panics. [...]
> >>Any help will be appreciated.
> >
> Sorry, didn't spot your previous email.
No problem ;).

> I've not set aside time to investigate further, but turning HT off made
> the problem go away. Would be interested to hear further reports.

Server oopsed again 10 minutes ago. Same symptoms. The kernel upgrade did not 
help... Would an update to an 2.6 kernel help or should I better turn 
hyperthreading off?

klaus

