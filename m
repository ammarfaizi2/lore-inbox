Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751348AbWFOKa1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbWFOKa1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 06:30:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWFOKa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 06:30:27 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:52966 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S1751348AbWFOKa0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 06:30:26 -0400
Subject: Re: [Ubuntu PATCH] Make btsco headset (a bluetooth device) work
From: Marcel Holtmann <marcel@holtmann.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
In-Reply-To: <44909A48.905@oracle.com>
References: <44909A48.905@oracle.com>
Content-Type: text/plain
Date: Thu, 15 Jun 2006 12:27:40 +0200
Message-Id: <1150367260.6565.1.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

> Make btsco headset (a bluetooth device) work.
> Reference: https://launchpad.net/distros/ubuntu/+source/linux-source-2.6.15/+bug/48910
> 
> http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=e9cb99036e650dabc5e9d7037d5a728176b42aca

this patch is not ready for mainline. The -mm kernel contains a more
better patch to address this problem, but even that should not end up in
mainline. I am working on a real solution for this issue.

Regards

Marcel


