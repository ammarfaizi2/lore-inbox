Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBUXHi>; Wed, 21 Feb 2001 18:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129181AbRBUXH0>; Wed, 21 Feb 2001 18:07:26 -0500
Received: from sgi.SGI.COM ([192.48.153.1]:19779 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S129170AbRBUXHQ>;
	Wed, 21 Feb 2001 18:07:16 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alberto Bertogli <albertogli@telpin.com.ar>
cc: linux-kernel@vger.kernel.org
Subject: Re: "Unable to handle kernel paging request" x 3 
In-Reply-To: Your message of "Wed, 21 Feb 2001 13:47:21 -0300."
             <982774041.3a93f1191add3@webmail.telpin.com.ar> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 22 Feb 2001 10:06:48 +1100
Message-ID: <22839.982796808@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Feb 2001 13:47:21 -0300 (ARST), 
Alberto Bertogli <albertogli@telpin.com.ar> wrote:
>Kernel panic: Attemped to kill the idle task!
>In idle task - not syncing
>
>This last line doesn't appear on the ksymoops report, i really dont know why it 
>insists on cutting it.

Because it has nothing to do with the oops, it is a symptom, not a
cause.

