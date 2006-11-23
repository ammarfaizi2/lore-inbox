Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933238AbWKWIP4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933238AbWKWIP4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 03:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933239AbWKWIP4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 03:15:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:64953 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S933238AbWKWIPz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 03:15:55 -0500
Subject: Re: kernel BUG at fs/inode.c:1139!
From: Arjan van de Ven <arjan@infradead.org>
To: Sandeep Kumar <sandeepksinha@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@nl.linux.org>
In-Reply-To: <37d33d830611222337t20ff02f8xfee72aa9c7e64439@mail.gmail.com>
References: <37d33d830611222337t20ff02f8xfee72aa9c7e64439@mail.gmail.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Thu, 23 Nov 2006 09:15:53 +0100
Message-Id: <1164269753.31358.774.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-23 at 13:07 +0530, Sandeep Kumar wrote:
> Hi all, I got  the following error insidea kernel module.
> 
> My module made a call to the blkdev_get ( ) inside the module and I
> get the followi

Hi,

you forgot to attach your (full!) source code, or at least an URL to
your project page where we could download the source... how are we
supposed to help you ???? Please reply with this.

Greetings,
   Arjan van de Ven
> 
-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

