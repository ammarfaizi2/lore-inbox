Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262048AbVHCE6p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262048AbVHCE6p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 00:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbVHCE6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 00:58:44 -0400
Received: from terminus.zytor.com ([209.128.68.124]:8151 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262048AbVHCE6o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 00:58:44 -0400
Message-ID: <42F04EB3.6040007@zytor.com>
Date: Tue, 02 Aug 2005 21:57:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: mkrufky@m1k.net
CC: Bodo Eggert <7eggert@gmx.de>, Steven Rostedt <rostedt@goodmis.org>,
       Sean Bruno <sean.bruno@dsl-only.net>, Lee Revell <rlrevell@joe-job.com>,
       webmaster@kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Testing RC kernels [KORG]
References: <Pine.LNX.4.58.0508030214150.7510@be1.lrz> <42F04632.5070109@zytor.com> <42F048B5.8030000@m1k.net>
In-Reply-To: <42F048B5.8030000@m1k.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky wrote:
> 
> Why not just have the scripts plug values into a database, and have the 
> html/php be formatted like Bodo suggests, and reads content from database?
> Very simple, less maintenance... Only requires 1 initial redesign, and 
> easier maintainence of the scripts that you speak of.
> 

The issue is to generate the values, not present them.

	-hpa
