Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261662AbVEVUkB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbVEVUkB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 16:40:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVEVUkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 16:40:00 -0400
Received: from build.arklinux.osuosl.org ([140.211.166.26]:51591 "EHLO
	mail.arklinux.org") by vger.kernel.org with ESMTP id S261688AbVEVUj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 16:39:57 -0400
From: Bernhard Rosenkraenzer <bero@arklinux.org>
Organization: Ark Linux team
To: Patrick McFarland <pmcfarland@downeast.net>
Subject: Re: [OT] Joerg Schilling flames Linux on his Blog
Date: Sun, 22 May 2005 22:40:10 +0200
User-Agent: KMail/1.8
Cc: Andrew Haninger <ahaning@gmail.com>, linux-kernel@vger.kernel.org
References: <200505201345.15584.pmcfarland@downeast.net> <105c793f050521182269294d64@mail.gmail.com> <200505220051.23222.pmcfarland@downeast.net>
In-Reply-To: <200505220051.23222.pmcfarland@downeast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505222240.11081.bero@arklinux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 22 May 2005 06:50, Patrick McFarland wrote:
> I really wish someone would build a replacement for cdrecord, but Joerg
> just hasn't pissed off that potential author enough.

Actually it has
http://www.freesoftware.fsf.org/dvdrtools/

It's a fork of the last "free" cdrecord (as in, without #ifdef NOT_MY_VERSION 
printf("Warning, you're using broken crap") and eliminates quite a few 
braindamages, such as the build system, the absence of DVD support, the 
anti-Linux and anti-GNU-Make comments and associated delays, but is otherwise 
still pretty close to the original (help in fixing the rest of the rest is 
welcome!).

LLaP
bero
