Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290862AbSAaDLB>; Wed, 30 Jan 2002 22:11:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290867AbSAaDKv>; Wed, 30 Jan 2002 22:10:51 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:54243 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S290862AbSAaDKn>;
	Wed, 30 Jan 2002 22:10:43 -0500
Date: Wed, 30 Jan 2002 22:10:41 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Benjamin Pharr <ben@benpharr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux/zutil.h
Message-ID: <20020130221041.B22862@havoc.gtf.org>
In-Reply-To: <20020131024809.GA12041@hst000004380um.kincannon.olemiss.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020131024809.GA12041@hst000004380um.kincannon.olemiss.edu>; from ben@benpharr.com on Wed, Jan 30, 2002 at 08:48:09PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2002 at 08:48:09PM -0600, Benjamin Pharr wrote:
> deflate.c:52: linux/zutil.h: No such file or directory

cd $MY_SOURCE_TREE
mv linux/zconf.h linux/zutil.h include/linux

