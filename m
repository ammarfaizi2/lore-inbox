Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262230AbUKWGzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262230AbUKWGzc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:55:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262235AbUKWGy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:54:28 -0500
Received: from farley.sventech.com ([69.36.241.87]:58290 "EHLO
	farley.sventech.com") by vger.kernel.org with ESMTP id S262230AbUKWGvN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:51:13 -0500
Date: Mon, 22 Nov 2004 22:51:10 -0800
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC/v1][11/12] Add InfiniBand Documentation files
Message-ID: <20041123065110.GA3959@sventech.com>
References: <20041122714.taTI3zcdWo5JfuMd@topspin.com> <20041122714.AyIOvRY195EGFTaO@topspin.com> <20041122225335.GE15634@kroah.com> <52sm71bie2.fsf@topspin.com> <20041122230533.GB13083@kroah.com> <20041122233047.GH27658@sventech.com> <20041123064508.GC22493@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123064508.GC22493@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004, Greg KH <greg@kroah.com> wrote:
> On Mon, Nov 22, 2004 at 03:30:47PM -0800, Johannes Erdfelt wrote:
> > On Mon, Nov 22, 2004, Greg KH <greg@kroah.com> wrote:
> > > People who do not use udev will not like you.
> > 
> > I don't quite understand this. Given things like udev, wouldn't dynamic
> > majors work just like having a static major number?
> 
> Yes, but people who do not use udev, will have a hard time creating the
> device nodes by hand every time.

Ok, I can understand that for now.

Is the eventual plan to move to dynamic majors for all devices?

JE

