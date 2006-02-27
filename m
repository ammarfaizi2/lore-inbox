Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbWB0WSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbWB0WSL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 17:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWB0WSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 17:18:11 -0500
Received: from smtp106.rog.mail.re2.yahoo.com ([68.142.225.204]:47030 "HELO
	smtp106.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932340AbWB0WSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 17:18:10 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Received:Subject:From:To:Cc:In-Reply-To:References:Content-Type:Date:Message-Id:Mime-Version:X-Mailer:Content-Transfer-Encoding;
  b=SPz0bxmFuGdOiKOJXbsgNNO7/7mHGuFi4hT/WqDKqFp8YC6eArn9Wd5+nIx1kmqYc+SoJt+Kk5QyomnrWjykckdTbhJkFOlHMM48lIRtIXT40G2viTJR0dcB8DJl42Ac8M357s9HHYaKgDT1moiyup5+B+yotEh6EGf+NSPGZlA=  ;
Subject: Re: [2.6 patch] make UNIX a bool
From: "James C. Georgas" <jgeorgas@rogers.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060225160150.GX3674@stusta.de>
References: <20060225160150.GX3674@stusta.de>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 17:18:06 -0500
Message-Id: <1141078686.28136.20.camel@Rainsong.home>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-25-02 at 17:01 +0100, Adrian Bunk wrote:
> CONFIG_UNIX=m doesn't make much sense.

I've been building it as a module forever. I often load kernels from
floppy disk, and building CONFIG_UNIX as a module often makes the
difference between the kernel fitting or not fitting on the disk. Could
we please keep this functionality?

-- 
James C. Georgas <jgeorgas@rogers.com>

