Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262380AbUGFBQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262380AbUGFBQc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 21:16:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUGFBQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 21:16:32 -0400
Received: from quest.jpl.nasa.gov ([137.78.177.125]:63426 "EHLO
	quest.jpl.nasa.gov") by vger.kernel.org with ESMTP id S262380AbUGFBQb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 21:16:31 -0400
In-Reply-To: <20040705144436.62544a3d.pj@sgi.com>
References: <2e9is-5YT-1@gated-at.bofh.it> <2e9iu-5YT-5@gated-at.bofh.it> <2ecq2-80i-1@gated-at.bofh.it> <7ab39013.0407042237.40ea9035@posting.google.com> <20040705064010.C9BFB5F7AA@attila.bofh.it> <9FC7DA98-CEA3-11D8-B083-000A95820F30@alumni.caltech.edu> <20040705144436.62544a3d.pj@sgi.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1C37F9C6-CEEA-11D8-B083-000A95820F30@alumni.caltech.edu>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Mark Adler <madler@alumni.caltech.edu>
Subject: Re: [PATCH] gcc 3.5 fixes
Date: Mon, 5 Jul 2004 18:16:29 -0700
To: Paul Jackson <pj@sgi.com>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 5, 2004, at 2:44 PM, Paul Jackson wrote:
> I'm not a lawyer, but I don't see why you'd want the copyright notice
> in the executable:

It's not about the copyright.  I like the string kept in the object 
code so that I and others can find out where the code is used and what 
version is in use.  This in fact turned out to be useful when a 
security vulnerability was found in versions 1.1.3 and earlier and a 
script could search for executables with the offending code.

mark

