Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVHCEWM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVHCEWM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 00:22:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVHCEWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 00:22:12 -0400
Received: from terminus.zytor.com ([209.128.68.124]:57035 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262039AbVHCEVo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 00:21:44 -0400
Message-ID: <42F04632.5070109@zytor.com>
Date: Tue, 02 Aug 2005 21:21:06 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bodo Eggert <7eggert@gmx.de>
CC: Steven Rostedt <rostedt@goodmis.org>, Sean Bruno <sean.bruno@dsl-only.net>,
       Lee Revell <rlrevell@joe-job.com>, webmaster@kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Michael Krufky <mkrufky@m1k.net>
Subject: Re: Testing RC kernels [KORG]
References: <Pine.LNX.4.58.0508030214150.7510@be1.lrz>
In-Reply-To: <Pine.LNX.4.58.0508030214150.7510@be1.lrz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> 
> I hacked some changes to create vogon-compatibility. Maybe you like it.
> I'm not completely happy, but it's too late now.
> 
> Changes:
> - Make first column more terse
> - Move full download links to a seperate table, where they can be found.
> - Add <h2> headings above the patches and above the tarballs
> - Add some hints
> - Create a dead link to a patching-HOWTO
> - Add a 'applies to:' column
> - fix legend to match changes
> 

This is completely useless.  The issue isn't the formatting, the issue 
is to make yet another change to an already hard-to-maintain set of scripts.

	-hpa
