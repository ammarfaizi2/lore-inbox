Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbUBXKq6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 05:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262185AbUBXKq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 05:46:58 -0500
Received: from [213.78.161.131] ([213.78.161.131]:28544 "HELO stockwith.co.uk")
	by vger.kernel.org with SMTP id S262220AbUBXKqM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 05:46:12 -0500
From: Chris Lingard <chris@ukpost.com>
To: MALET JL <malet.jean-luc@laposte.net>
Subject: Re: [linux 2.6.3] [gcc 3.3.3] compile errors. Now OT
Date: Tue, 24 Feb 2004 10:46:07 +0000
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <403911B3.10601@laposte.net> <200402231658.53516.chris@ukpost.com> <403B0E92.60903@laposte.net>
In-Reply-To: <403B0E92.60903@laposte.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402241046.07323.chris@ukpost.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 February 2004 8:42 am, MALET JL wrote:

> O_O! question what is the purpose of having two set of headers? do you
> think this is good work to provide a unsable set of headers with a
> software? why not include the RedHat's one then......

I think that this is off topic for this list; so I will email you direct, 
quite soon, with some reasons and links.

Nothing wrong with using RedHat, nice distro; but your question was about
building with 2.6.x headers.  The functionality of 2.6.x is needed by glibc; 
but not in user space.  How that is achieved is quite difficult.

Chris
