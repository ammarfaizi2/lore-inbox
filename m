Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262343AbULOLzJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbULOLzJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 06:55:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbULOLzI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 06:55:08 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:29861 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262341AbULOLy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 06:54:56 -0500
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
To: David Jacoby <dj@outpost24.com>
Subject: Re: Linux kernel IGMP vulnerabilities, PATCH IS BROKEN!
Date: Wed, 15 Dec 2004 12:54:37 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org
References: <41BFF931.6030205@outpost24.com> <20041215.180839.93043538.yoshfuji@linux-ipv6.org> <41C024B0.4010009@outpost24.com>
In-Reply-To: <41C024B0.4010009@outpost24.com>
Organization: Linux-Systeme GmbH
X-Operating-System: Linux 2.4.20-wolk4.16 i686 GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412151254.37612@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 December 2004 12:49, David Jacoby wrote:

> Anyone else tried to apply this patch? The patch does work but not
> properly.
> I guess the machie is secure against the DoS attack but after i
> installed the patch
> i cant use SSH.When i tryed to SSH i didnt get any password prompt.
> user@autopsia:~$ ssh user@192.168.0.1
> Permission denied, please try again.
> Permission denied, please try again.
> Permission denied (publickey,password,keyboard-interactive).
> The patch will crash SSH :|

without looking at the patch, I think this isn't the causer of the patch at 
all.

ciao, Marc
