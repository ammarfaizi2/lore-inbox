Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318325AbSGYFbp>; Thu, 25 Jul 2002 01:31:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318324AbSGYFbp>; Thu, 25 Jul 2002 01:31:45 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:36104 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S318325AbSGYF1C>;
	Thu, 25 Jul 2002 01:27:02 -0400
Date: Wed, 24 Jul 2002 22:29:57 -0700
From: Greg KH <greg@kroah.com>
To: Martin Brulisauer <martin@uceb.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: type safe lists (was Re: PATCH: type safe(r) list_entry repacement: generic_out_cast)
Message-ID: <20020725052957.GA13523@kroah.com>
References: <20020723114703.GM11081@unthought.net> <3D3E75E9.28151.2A7FBB2@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3E75E9.28151.2A7FBB2@localhost>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Thu, 27 Jun 2002 04:21:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 09:39:53AM +0200, Martin Brulisauer wrote:
> By the way: Multiline C Macros are depreached and will not be
> supported by a future version of gcc and as for today will generate a
> bunch of warnings.

Why is this?  Is it a C99 requirement?

thanks,

greg k-h
