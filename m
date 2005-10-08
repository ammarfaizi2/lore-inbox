Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932111AbVJHNIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932111AbVJHNIs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 09:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbVJHNIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 09:08:48 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:13317 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S932111AbVJHNIs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 09:08:48 -0400
From: Felix Oxley <lkml@oxley.org>
To: Danny ter Haar <dth@cistron.nl>
Subject: Re: 2.6.13-rt12: irqs hard off for 657 usecs
Date: Sat, 8 Oct 2005 14:08:34 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <1128724690.17981.57.camel@mindpipe> <20051008115828.GA29042@elte.hu> <di8ebc$b9k$1@news.cistron.nl>
In-Reply-To: <di8ebc$b9k$1@news.cistron.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510081408.34948.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 08 October 2005 13:33, Danny ter Haar wrote:

> Ingo,
> could this be the same bug that's been hitting me since 2.6.13* ?
> usenetgateway (heavy used server) with scsi/gig-E ethernet which
> crashes within couple of days.

Danny, 
I wasn't sure from your post whether you are running Ingo's RT patchset or 
not?
Also, maybe you should not run unstable kernels on a production machine? :-)
