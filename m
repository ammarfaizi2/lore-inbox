Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUJLPiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUJLPiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 11:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265971AbUJLPip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 11:38:45 -0400
Received: from gate.corvil.net ([213.94.219.177]:27152 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S265127AbUJLPi3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 11:38:29 -0400
Message-ID: <416BFA6F.2060408@draigBrady.com>
Date: Tue, 12 Oct 2004 16:38:23 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: No mtime updates for loopback mounted filesystems
References: <416BF891.9080806@draigBrady.com>
In-Reply-To: <416BF891.9080806@draigBrady.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P@draigBrady.com wrote:
> I've noticed recently that files mounted loopback
> do not have their mtimes updated if any writes are
> done to the filesystem.

The above is still valid.

> In addition, files within
> the loopback mounted filesystem do not have their
> mtime updated if changed.

I did see this but it must have been fixed,
as I can't repeat it on 2.4.26

Pádraig.
