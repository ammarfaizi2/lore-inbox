Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264252AbUAUViA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 16:38:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264241AbUAUVhr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 16:37:47 -0500
Received: from mail41-s.fg.online.no ([148.122.161.41]:49060 "EHLO
	mail41-s.fg.online.no") by vger.kernel.org with ESMTP
	id S264233AbUAUVhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 16:37:45 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: logging all input and output on a tty
References: <87ad4h5juk.fsf@online.no>
	<20040121171227.GO19425@schnapps.adilger.int>
From: Esben Stien <executiv@online.no>
Date: 21 Jan 2004 22:37:01 +0100
In-Reply-To: <20040121171227.GO19425@schnapps.adilger.int>
Message-ID: <87ptdd3rwi.fsf@online.no>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3.50
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger <adilger@clusterfs.com> writes:

> This can be done relatively easily in userspace via "script" or "screen".

Yes, though I want this for monitoring. I don't want to start neither script nor screen when a user logs into a tty. I just want to log everything written in a tty.  

-- 
b0ef

