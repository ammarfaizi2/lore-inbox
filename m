Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272255AbTHRS4d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:56:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272259AbTHRS4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:56:33 -0400
Received: from mail1.kontent.de ([81.88.34.36]:55680 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S272255AbTHRS4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:56:31 -0400
Message-ID: <3F413D4D.60607@triphoenix.de>
Date: Mon, 18 Aug 2003 20:55:41 +0000
From: Dennis Bliefernicht <news.REMOVEME@triphoenix.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030805
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: cannot stat hidden windows files in a cdrom...
References: <lWC9.31L.1@gated-at.bofh.it>
In-Reply-To: <lWC9.31L.1@gated-at.bofh.it>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alessandro Salvatori wrote:
 > if a cdrom burnt under windows contains hidden files you cannot see
 > and/or read them from linux. while you can see hidden files in mounted
 > windows filesystems. This happens with any Linux kernel and i have no
 > idea how windows does burn these hidden files on cdroms and wether or
 > not it would be good for Linux to read them, anyway there is a
 > "Microsoft Joliet CDROM extensions" voice that claims to let you read
 > Joliet cdroms and maybe you would like these file to be read too.

Did you try the unhide mount option?

