Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbUJaSdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbUJaSdG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Oct 2004 13:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbUJaSdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Oct 2004 13:33:05 -0500
Received: from LPBPRODUCTIONS.COM ([68.98.211.131]:58756 "HELO
	lpbproductions.com") by vger.kernel.org with SMTP id S261493AbUJaSc6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Oct 2004 13:32:58 -0500
From: Matt Heler <lkml@lpbproductions.com>
Reply-To: lkml@lpbproductions.com
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.10-rc1-mm2: konqueror crash because of cputime patches
Date: Sun, 31 Oct 2004 11:32:21 -0700
User-Agent: KMail/1.7.50
Cc: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
References: <200410291823.34175.rjw@sisk.pl> <200410301837.25828.rjw@sisk.pl> <200410311651.23631.rjw@sisk.pl>
In-Reply-To: <200410311651.23631.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410311132.22766.lkml@lpbproductions.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 October 2004 8:51 am, Rafael J. Wysocki wrote:
> Done.  Evidently, if the cputime patches:
>
> cputime-introduce-cputime-fix.patch
> cputime-introduce-cputime.patch
> cputime-missing-pieces.patch
>


Reversing theese fixed my konqueror issues to. In 2.6.10-rc1-mm2 , konqueror 
would crash instantly when I tried browsing a webpage ( any page ).


mattt
