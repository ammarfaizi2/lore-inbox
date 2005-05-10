Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbVEJEeQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbVEJEeQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 00:34:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVEJEeQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 00:34:16 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:28790 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S261469AbVEJEeN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 00:34:13 -0400
Date: Tue, 10 May 2005 06:35:27 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Ajay Patel <patela@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Placing external module's object into different directory
Message-ID: <20050510043527.GB8398@mars.ravnborg.org>
References: <90f56e48050509182833e60705@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90f56e48050509182833e60705@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 09, 2005 at 06:28:29PM -0700, Ajay Patel wrote:
> Hi,
> 
> I am using 2.6.11.4 source.
> I am compiling linux kernel with source
> and objects are in different directory. (Using O= options)
> 
> I have an external module in different directory .
> I can compile this external module without a problem.  
> But objects/modules are placed into same directory as source.
> 
> Is there any way to put external modules objects/modules
> into different directory? 
No - thats not possible.

	Sam
