Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751762AbWD0XIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762AbWD0XIM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 19:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbWD0XIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 19:08:12 -0400
Received: from accolon.hansenpartnership.com ([64.109.89.108]:12161 "EHLO
	accolon.hansenpartnership.com") by vger.kernel.org with ESMTP
	id S1751762AbWD0XIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 19:08:11 -0400
Subject: Re: [2.6 patch] let X86_VOYAGER depend on SMP
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20060427160604.66b2a297.akpm@osdl.org>
References: <20060427203350.GR3570@stusta.de>
	 <20060427160604.66b2a297.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 27 Apr 2006 18:08:06 -0500
Message-Id: <1146179286.3528.54.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-04-27 at 16:06 -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@stusta.de> wrote:
> I was kinda waiting for James to express an opinion.  In theory it'd be
> better to make uniproc-on-Voyager build, boot and run like the wind.

I do have making uniprocessor build work on my todo list.  There are
actually a surprising number of non-smp machines out their (mainly
3360s).

James


