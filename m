Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265844AbSLNTma>; Sat, 14 Dec 2002 14:42:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265851AbSLNTma>; Sat, 14 Dec 2002 14:42:30 -0500
Received: from out002pub.verizon.net ([206.46.170.141]:54720 "EHLO
	out002.verizon.net") by vger.kernel.org with ESMTP
	id <S265844AbSLNTm3>; Sat, 14 Dec 2002 14:42:29 -0500
Message-ID: <3DFB8B7C.10802@verizon.net>
Date: Sat, 14 Dec 2002 14:50:20 -0500
From: Stephen Wille Padnos <stephen.willepadnos@verizon.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Walrond <andrew@walrond.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
References: <200212141355.gBEDtb7q000952@darkstar.example.net> <3DFB3983.3090602@walrond.org>
In-Reply-To: <3DFB3983.3090602@walrond.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out002.verizon.net from [64.223.83.18] at Sat, 14 Dec 2002 13:50:17 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Walrond wrote:

> [snip]

> cat d/x
> "a/x"
>
> cat d/y
> "b/y"
>
> cat d/z
> "c/z" 

What would you expect to happen if you then did:
echo "d/w" > d/w

Which physical directory would you expect a new file to go into?

- Steve


