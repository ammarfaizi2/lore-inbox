Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267762AbUHEQMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267762AbUHEQMi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 12:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267763AbUHEQMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 12:12:38 -0400
Received: from cantor.suse.de ([195.135.220.2]:62418 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267762AbUHEQMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 12:12:37 -0400
Date: Thu, 5 Aug 2004 18:12:36 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Jackson <pj@sgi.com>
Cc: zaitcev@redhat.com, linux-kernel@vger.kernel.org, spot@redhat.com,
       akpm@osdl.org
Subject: Re: Make MAX_INIT_ARGS 25
Message-ID: <20040805161236.GD26568@suse.de>
References: <20040804193243.36009baa@lembas.zaitcev.lan> <20040805143933.GA19219@suse.de> <20040805090843.5eaeed43.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040805090843.5eaeed43.pj@sgi.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Aug 05, Paul Jackson wrote:

> > Can the whole thing be dynamic?
> 
> We're a little short of dynamic memory allocation mechanisms
> this early in the boot, I'm afraid.

Ok, I'm fine with 32, we have such a patch since ages.


-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
