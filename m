Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265170AbUFATnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265170AbUFATnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 15:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265172AbUFATnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 15:43:14 -0400
Received: from lindsey.linux-systeme.com ([62.241.33.80]:64004 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265170AbUFATnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 15:43:14 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org, orders@nodivisions.com
Subject: Re: swappiness ignored
Date: Tue, 1 Jun 2004 21:42:54 +0200
User-Agent: KMail/1.6.2
References: <40B43B5F.8070208@nodivisions.com> <200406011136.17055@WOLK> <40BCDB3E.3050705@nodivisions.com>
In-Reply-To: <40BCDB3E.3050705@nodivisions.com>
X-Operating-System: Linux 2.6.5-wolk3.0 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200406012142.54909@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 June 2004 21:38, Anthony DiSante wrote:

Hi Anthony,

> > I bet you have /proc/sys/vm/autoswappiness or the previous version of it
> > w/o /proc stuff.

> Ah, yes, I do, and it's set to one.  So if I set that to zero, then the
> kernel won't automatically adjust /proc/sys/vm/swappiness?

right :)

ciao, Marc
