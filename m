Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261289AbVFSTe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVFSTe1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Jun 2005 15:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261285AbVFSTe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Jun 2005 15:34:27 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:46260 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S261290AbVFSTeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Jun 2005 15:34:19 -0400
From: Jan De Luyck <lkml@kcore.org>
To: Edwin Eefting <psy@datux.nl>
Subject: Re: [2.6.12] XFS: Undeletable directory
Date: Sun, 19 Jun 2005 20:34:18 +0200
User-Agent: KMail/1.8.1
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
References: <200506191904.49639.lkml@kcore.org> <Pine.LNX.4.63.0506191924430.7686@hobbybop>
In-Reply-To: <Pine.LNX.4.63.0506191924430.7686@hobbybop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506192034.18690.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 19 June 2005 21:25, Edwin Eefting wrote:
> ls -la 4207214/ also shows nothing?
> perhaps there's something weirds thats hidden.
>

Nothing out of the ordinary:

devilkin@precious:/lost+found$ ls -la 4207214/
total 8
drwxrwxrwx  2 root root 8192 Jun 19  2005 .
drwxr-xr-x  3 root root   20 Jun 19  2005 ..
devilkin@precious:/lost+found$ 

Jan

-- 
  We are not anticipating any emergencies.
