Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262746AbRE3MF4>; Wed, 30 May 2001 08:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262747AbRE3MFg>; Wed, 30 May 2001 08:05:36 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:27398 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262746AbRE3MFa>;
	Wed, 30 May 2001 08:05:30 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Stephen Cornell <cornell@zoo.cam.ac.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.2.18 oops 
In-Reply-To: Your message of "Wed, 30 May 2001 12:17:55 +0100."
             <Pine.GSO.3.95.1010530120922.1083A-100000@parasite> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 30 May 2001 22:05:25 +1000
Message-ID: <19487.991224325@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2001 12:17:55 +0100 (BST), 
Stephen Cornell <cornell@zoo.cam.ac.uk> wrote:
>ksymoops doesn't seem to have done its job correctly

ksymoops did the best it could when fed with data that has been stamped
on by klogd.  Always run klogd as "klogd -x" so it keeps its sticky
fingers off the oops report.

