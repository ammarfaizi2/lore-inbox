Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319135AbSIDNoE>; Wed, 4 Sep 2002 09:44:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319167AbSIDNoE>; Wed, 4 Sep 2002 09:44:04 -0400
Received: from capsi.xs4all.nl ([213.84.61.91]:64273 "HELO capsi.com")
	by vger.kernel.org with SMTP id <S319135AbSIDNoD>;
	Wed, 4 Sep 2002 09:44:03 -0400
Date: Wed, 4 Sep 2002 15:48:36 +0200
From: Alexander Kellett <lypanov@kde.org>
To: Greg KH <greg@kroah.com>
Cc: Martin Brulisauer <martin@uceb.org>, linux-kernel@vger.kernel.org
Subject: Re: type safe lists (was Re: PATCH: type safe(r) list_entry repacement: generic_out_cast)
Message-ID: <20020904134836.GA481@ezri.capsi>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Martin Brulisauer <martin@uceb.org>, linux-kernel@vger.kernel.org
References: <20020723114703.GM11081@unthought.net> <3D3E75E9.28151.2A7FBB2@localhost> <20020725052957.GA13523@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725052957.GA13523@kroah.com>
User-Agent: Mutt/1.4i
X-Disclaimer: My opinions do not necessarily represent those of KDE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 10:29:57PM -0700, Greg KH wrote:
> On Wed, Jul 24, 2002 at 09:39:53AM +0200, Martin Brulisauer wrote:
> > By the way: Multiline C Macros are depreached and will not be
> > supported by a future version of gcc and as for today will generate a
> > bunch of warnings.
> 
> Why is this?  Is it a C99 requirement?

afaik its multi line strings that have been deprecated.

Alex
