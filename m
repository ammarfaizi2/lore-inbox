Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262319AbUKVS4A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262319AbUKVS4A (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 13:56:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbUKVSyK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 13:54:10 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:21709 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262266AbUKVSwX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 13:52:23 -0500
Message-ID: <41A23566.6080903@namesys.com>
Date: Mon, 22 Nov 2004 10:52:22 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: Amit Gud <amitgud1@gmail.com>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: file as a directory
References: <2c59f00304112205546349e88e@mail.gmail.com> <200411221759.iAMHx7QJ005491@turing-police.cc.vt.edu>
In-Reply-To: <200411221759.iAMHx7QJ005491@turing-police.cc.vt.edu>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>
>(Hint - "file as directory" broke a number of programs that didn't
>expect that a file *could* be a directory, when run on a reiser4
>filesystem...)
>  
>
It broke extraordinarily few.
