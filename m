Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUGFEoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUGFEoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 00:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUGFEoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 00:44:00 -0400
Received: from quest.jpl.nasa.gov ([137.78.177.125]:29950 "EHLO
	quest.jpl.nasa.gov") by vger.kernel.org with ESMTP id S263024AbUGFEn7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 00:43:59 -0400
In-Reply-To: <1089085868.8452.2.camel@localhost>
References: <2e9is-5YT-1@gated-at.bofh.it> <2e9iu-5YT-5@gated-at.bofh.it> <2ecq2-80i-1@gated-at.bofh.it> <7ab39013.0407042237.40ea9035@posting.google.com> <20040705064010.C9BFB5F7AA@attila.bofh.it> <9FC7DA98-CEA3-11D8-B083-000A95820F30@alumni.caltech.edu> <20040705144436.62544a3d.pj@sgi.com> <1C37F9C6-CEEA-11D8-B083-000A95820F30@alumni.caltech.edu> <1089085868.8452.2.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1820F1EE-CF07-11D8-B083-000A95820F30@alumni.caltech.edu>
Content-Transfer-Encoding: 7bit
Cc: Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
From: Mark Adler <madler@alumni.caltech.edu>
Subject: Re: [PATCH] gcc 3.5 fixes
Date: Mon, 5 Jul 2004 21:43:58 -0700
To: Jesse Stockall <stockall@magma.ca>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 5, 2004, at 8:51 PM, Jesse Stockall wrote:
> Did I miss something or are you saying that the version in the kernel
> has a security vulnerability?

If the kernel has 1.1.3, then yes.  You can get 1.1.4 here, which 
remedies that vulnerability:

     http://www.gzip.org/zlib/zlib-1.1.4.tar.gz

mark

