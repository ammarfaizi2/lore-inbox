Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267891AbUGaBtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267891AbUGaBtS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 21:49:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267892AbUGaBtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 21:49:18 -0400
Received: from 23.80-202-99.nextgentel.com ([80.202.99.23]:21985 "EHLO
	gspr.dyndns.org") by vger.kernel.org with ESMTP id S267891AbUGaBtR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 21:49:17 -0400
From: Gard Spreemann <gspr@gspr.dyndns.org>
To: sankarshana rao <san_wipro@yahoo.com>
Subject: Re: storing a Filesystem in a file
Date: Sat, 31 Jul 2004 03:49:16 +0200
User-Agent: KMail/1.6.2
References: <20040731014626.72400.qmail@web50903.mail.yahoo.com>
In-Reply-To: <20040731014626.72400.qmail@web50903.mail.yahoo.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407310349.16703.gspr@gspr.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 31 July 2004 03:46, you wrote:
> Hi,
> I have a requirement to create a file system in a file
> . Is this possible???
>
> thx in advance...

The subject and body seem to conflict a bit.
Answering the subject: Yes. Check out the dd command. Example: 
dd if=/dev/cdrom of=file.iso
