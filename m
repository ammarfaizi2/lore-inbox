Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbUJWQ50@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbUJWQ50 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 12:57:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbUJWQ50
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 12:57:26 -0400
Received: from nysv.org ([213.157.66.145]:22920 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S261240AbUJWQ5Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 12:57:24 -0400
Date: Sat, 23 Oct 2004 19:57:12 +0300
To: linux-kernel@vger.kernel.org
Cc: reiserfs-list@namesys.com
Subject: Re: 2.6.9-mm1
Message-ID: <20041023165712.GR26192@nysv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <417A7EF9.70007@namesys.com>
User-Agent: Mutt/1.5.6i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

>Please make large keys the default, and hide the ability to 
>choose small keys by taking it out of the configuration menu and burying 
>it in a .h file.

Stupid question, why have small keys at all?

Someone said once that he didn't want to use large keys because they added
no value to him and small keys wasted less space. If there are people like
this around, burying it is not cool, but if there aren't, maybe small keys
should be ripped out?

-- 
mjt

