Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751674AbWEKNAX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751674AbWEKNAX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 09:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWEKNAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 09:00:22 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50056 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751632AbWEKNAW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 09:00:22 -0400
Subject: Re: [PATCH -mm] updated megaraid gcc 4.1 warning fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Daniel Walker <dwalker@mvista.com>
Cc: akpm@osdl.org, Seokmann.Ju@lsil.com, linux-kernel@vger.kernel.org
In-Reply-To: <200605101726.k4AHQqZf004367@dwalker1.mvista.com>
References: <200605101726.k4AHQqZf004367@dwalker1.mvista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Thu, 11 May 2006 14:12:25 +0100
Message-Id: <1147353145.26130.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2006-05-10 at 10:26 -0700, Daniel Walker wrote:
> Hows that Alan?
> 
> Fixes the following warning,
> 
> drivers/scsi/megaraid.c: In function ‘megadev_ioctl’:
> drivers/scsi/megaraid.c:3665: warning: ignoring return value of ‘copy_to_user’, declared with attribute warn_unused_result
> 
> Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Looks ok to me

