Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261693AbUDXSy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbUDXSy1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Apr 2004 14:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUDXSy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Apr 2004 14:54:27 -0400
Received: from prime.hereintown.net ([141.157.132.3]:20942 "EHLO
	prime.hereintown.net") by vger.kernel.org with ESMTP
	id S261693AbUDXSy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Apr 2004 14:54:26 -0400
Message-ID: <408AB7D6.4060305@hereintown.net>
Date: Sat, 24 Apr 2004 18:54:14 +0000
From: Chris Meadors <clubneon@hereintown.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cijoml@volny.cz
CC: linux-kernel@vger.kernel.org
Subject: Re: standart events for hotkeys?
References: <200404200042.24671.cijoml@volny.cz> <200404241900.28907.cijoml@volny.cz> <200404242014.15525.kim@holviala.com> <200404241918.22817.cijoml@volny.cz>
In-Reply-To: <200404241918.22817.cijoml@volny.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Semler wrote:

> and this is what I mean. We should start project collecting this. As PCI cards 
> list for example.

There are as many e-mail keys codes as there are e-mail programs.  And 
I'm sure there is over lap, where one keyboard's e-mail key, generates 
the same code as another's web browser key.  Also it doesn't really 
matter what a key is labeled, it could be assigned to anything.

What there should be is a program that is configurable, that says when 
you see this key event, do this.  And such programs do exist, for 
example the GNOME desktop has ACME.

All that has to be done is make sure the kernel passes this codes, and 
the user space program can gather them.  That seems to be working now.

-- 
Chris
