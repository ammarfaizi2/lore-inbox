Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265985AbUAEW5F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 17:57:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265993AbUAEW5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 17:57:04 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:35482 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S265985AbUAEWyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 17:54:33 -0500
Date: Mon, 5 Jan 2004 23:51:04 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Markus =?iso-8859-1?Q?H=E4stbacka?= <midian@ihme.org>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.4.24 released
Message-ID: <20040105225104.GD4987@louise.pinerecords.com>
References: <200401051355.i05DtvgC020415@hera.kernel.org> <1073321792.21338.2.camel@midux> <20040105171843.GA2407@alpha.home.local> <1073324505.21338.11.camel@midux> <20040105190619.GD10569@fs.tum.de> <1073336935.21983.4.camel@midux>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1073336935.21983.4.camel@midux>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan-05 2004, Mon, 23:08 +0200
Markus Hästbacka <midian@ihme.org> wrote:

> cd /usr/src
> cp linux-2.4.24/.config .
> rm -rvf /linux-2.4.24

Here you have deleted nothing (or a /linux-2.4.24 directory, if there
was one), which would explain the problems.

-- 
Tomas Szepe <szepe@pinerecords.com>
