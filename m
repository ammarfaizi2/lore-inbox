Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262191AbREXSfb>; Thu, 24 May 2001 14:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262195AbREXSfV>; Thu, 24 May 2001 14:35:21 -0400
Received: from noc.otenet.gr ([195.170.0.29]:65188 "EHLO noc.otenet.gr")
	by vger.kernel.org with ESMTP id <S262191AbREXSfG>;
	Thu, 24 May 2001 14:35:06 -0400
Date: Thu, 24 May 2001 21:34:46 +0300
From: Costas Tavernarakis <taver@otenet.gr>
To: Josh Logan <josh@wcug.wwu.edu>
Cc: Costas Tavernarakis <taver@otenet.gr>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx problem on -ac series
Message-ID: <20010524213446.A10378@noc.otenet.gr>
In-Reply-To: <20010524201518.A20971@noc.otenet.gr> <Pine.BSO.4.21.0105241114180.21043-100000@sloth.wcug.wwu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.BSO.4.21.0105241114180.21043-100000@sloth.wcug.wwu.edu>; from josh@wcug.wwu.edu on Thu, May 24, 2001 at 11:15:25AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2001 at 11:15:25AM -0700, Josh Logan wrote:
> 
> I have also seen this problem...  I don't have any ideas.  Is this a
> module or compiled in?
> 

Compiled in. It connects the boot disk.

Maybe it's not an aic7xxx problem but a pci one, since
2.4.5-pre uses the same version of the driver.
