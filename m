Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268325AbTBYU1p>; Tue, 25 Feb 2003 15:27:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268322AbTBYU0T>; Tue, 25 Feb 2003 15:26:19 -0500
Received: from vena.lwn.net ([206.168.112.25]:40654 "HELO eklektix.com")
	by vger.kernel.org with SMTP id <S268315AbTBYUY3>;
	Tue, 25 Feb 2003 15:24:29 -0500
Message-ID: <20030225203444.30004.qmail@eklektix.com>
To: randy.dunlap@verizon.net
Subject: Re: [RFC] seq_file_howto
cc: linux-kernel@vger.kernel.org
From: Jonathan Corbet <corbet@lwn.net>
Date: Tue, 25 Feb 2003 13:34:44 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> acme prodded me into doing this a few weeks (or months?) ago.
> It still needs some additional info for using single_open()
> and single_release(), but I'd like to get some comments on it
> and then add it to linux/Documentation/filesystems/ or post it
> on the web somewhere, like kernelnewbies.org.

Gee...I did one too, including a simple sample module which shows how it
all works; see http://lwn.net/Articles/22355/.  It's part of the larger
"driver porting" series at http://lwn.net/Articles/driver-porting/; there's
a dozen articles there now, most of which have passed out of the
subscription period and are freely available.

jon

Jonathan Corbet
Executive editor, LWN.net
corbet@lwn.net
