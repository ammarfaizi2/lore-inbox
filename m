Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263319AbSJ3C1g>; Tue, 29 Oct 2002 21:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263320AbSJ3C1g>; Tue, 29 Oct 2002 21:27:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:36357 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263319AbSJ3C1g>;
	Tue, 29 Oct 2002 21:27:36 -0500
Message-ID: <3DBF44F8.8010307@pobox.com>
Date: Tue, 29 Oct 2002 21:33:28 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       dhinds@zen.stanford.edu, alan@lxorguk.ukuu.org.uk
Subject: Re: [PATCH] Get rid of check_resource() before it becomes a problem
References: <20021030014105.1A9F82C47A@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Need to zap the export from kernel/ksyms.c too


