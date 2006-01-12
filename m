Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030459AbWALQXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030459AbWALQXQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 11:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030460AbWALQXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 11:23:16 -0500
Received: from mail.fieldses.org ([66.93.2.214]:5332 "EHLO pickle.fieldses.org")
	by vger.kernel.org with ESMTP id S1030459AbWALQXP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 11:23:15 -0500
Date: Thu, 12 Jan 2006 11:23:06 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>, qiyong@fc-cn.com,
       linux-kernel@vger.kernel.org
Subject: Re: why no -mm git tree?
Message-ID: <20060112162306.GB14138@fieldses.org>
References: <20060111055616.GA5976@localhost.localdomain> <20060110224451.44c9d3da.akpm@osdl.org> <20060111070043.GA7858@localhost.localdomain> <20060110231818.6164dba7.akpm@osdl.org> <4d8e3fd30601110436p286cfacap6618067c32e22a32@mail.gmail.com> <20060111091125.716bfcfc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060111091125.716bfcfc.akpm@osdl.org>
User-Agent: Mutt/1.5.11
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2006 at 09:11:25AM -0800, Andrew Morton wrote:
> Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> >  did you consider Stacked GIT as an alternative to quilt ?
> 
> I looked at the web page - stgit seems to be broken-out patches
> revision-controlled under git.

It doesn't really attempt to do revision control on the patches.

--b.
