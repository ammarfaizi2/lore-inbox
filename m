Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263154AbTJZN6N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 08:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263155AbTJZN6N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 08:58:13 -0500
Received: from morbo.e-centre.net ([66.154.82.3]:21455 "EHLO
	morbo.e-centre.net") by vger.kernel.org with ESMTP id S263154AbTJZN6K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 08:58:10 -0500
Date: Sun, 26 Oct 2003 08:57:59 -0500
From: iain d broadfoot <ibroadfo@cis.strath.ac.uk>
To: Nigel Cunningham <ncunningham@clear.net.nz>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Announce: Swsusp-2.0-2.6-alpha1
Message-ID: <20031026135759.GA1169@iain-vaio-fx405>
Mail-Followup-To: Nigel Cunningham <ncunningham@clear.net.nz>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1067069558.1975.54.camel@laptop-linux> <20031025192019.GA1033@iain-vaio-fx405> <20031025200524.GA1170@iain-vaio-fx405> <1067154164.14037.55.camel@laptop-linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067154164.14037.55.camel@laptop-linux>
X-Editor: Vim http://www.vim.org/
X-Operating-System: Linux/2.6.0-test8 (i686)
X-Uptime: 08:55:31 up 9 min,  4 users,  load average: 2.01, 1.58, 0.82
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Nigel Cunningham (ncunningham@clear.net.nz) wrote:
> You should be able to press escape to cancel; if the message stays for
> more than a couple of seconds, something is wrong. When you cancel, you
> should get messages in the log that will help me diagnose and fix the
> issue. You may need to run them through ksymoops to convert hex to
> procedure names.

Sorry, I forgot to mention that I did try hitting escape, with zero
response.

I also saw no swsusp messages in /var/log/messages beyond the startup
'resume device set to /dev/hda1' lines.

iain

-- 
"If sharing a thing in no way diminishes it, it is not rightly owned if it is
not shared." -- St. Augustine
