Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261352AbVFUMyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261352AbVFUMyQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 08:54:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVFUMxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 08:53:47 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:43951 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261310AbVFUMwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 08:52:41 -0400
Date: Tue, 21 Jun 2005 14:52:43 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: nanakos@wired-net.gr
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 sendfile
Message-ID: <20050621125243.GA7139@wohnheim.fh-wedel.de>
References: <50773.62.38.141.127.1119357138.squirrel@webmail.wired-net.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50773.62.38.141.127.1119357138.squirrel@webmail.wired-net.gr>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 June 2005 15:32:18 +0300, nanakos@wired-net.gr wrote:
> 
> can you tell me please how i can enable ( with a patch? ) the file-file
> sendfile system call feature???

1. Don't do this.
2. Don't do this, unless you really know what you're doing.
3. If you want to do it anyway, take a look at my cowlink patches:
http://wohnheim.fh-wedel.de/~joern/cowlink/

Jörn

-- 
Courage is not the absence of fear, but rather the judgement that
something else is more important than fear.
-- Ambrose Redmoon
