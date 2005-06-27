Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261841AbVF0VyF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261841AbVF0VyF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 17:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVF0VyF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 17:54:05 -0400
Received: from aeimail.aei.ca ([206.123.6.84]:55498 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S261841AbVF0Vwk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 17:52:40 -0400
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Benjamin LaHaise <bcrl@kvack.org>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Mon, 27 Jun 2005 17:53:12 -0400
User-Agent: KMail/1.8.1
Cc: Matt Mackall <mpm@selenic.com>, Pavel Machek <pavel@ucw.cz>,
       Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>, mercurial@selenic.com
References: <42B9E536.60704@pobox.com> <20050627194031.GK12006@waste.org> <20050627195134.GA17107@kvack.org>
In-Reply-To: <20050627195134.GA17107@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506271753.13247.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 27 June 2005 15:51, Benjamin LaHaise wrote:
> On Mon, Jun 27, 2005 at 12:40:31PM -0700, Matt Mackall wrote:
> >  $ export PYTHONPATH=${HOME}/lib/python  # add this to your .bashrc
> 
> This needs to be ${HOME}/lib64/python on x86-64.

Be careful.  This is not true on debian.

Ed Tomlinson
