Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbUKVXfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbUKVXfQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:35:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261224AbUKVXdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:33:14 -0500
Received: from farley.sventech.com ([69.36.241.87]:55206 "EHLO
	farley.sventech.com") by vger.kernel.org with ESMTP id S262447AbUKVXas
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:30:48 -0500
Date: Mon, 22 Nov 2004 15:30:47 -0800
From: Johannes Erdfelt <johannes@erdfelt.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] Re: [PATCH][RFC/v1][11/12] Add InfiniBand Documentation files
Message-ID: <20041122233047.GH27658@sventech.com>
References: <20041122714.taTI3zcdWo5JfuMd@topspin.com> <20041122714.AyIOvRY195EGFTaO@topspin.com> <20041122225335.GE15634@kroah.com> <52sm71bie2.fsf@topspin.com> <20041122230533.GB13083@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041122230533.GB13083@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004, Greg KH <greg@kroah.com> wrote:
> On Mon, Nov 22, 2004 at 02:58:45PM -0800, Roland Dreier wrote:
> >     Greg> Oh, have you asked for a real major number to be reserved
> >     Greg> for umad?
> > 
> > No, I think we're fine with a dynamic major.  Is there any reason to
> > want a real major?
> 
> People who do not use udev will not like you.

I don't quite understand this. Given things like udev, wouldn't dynamic
majors work just like having a static major number?

JE

