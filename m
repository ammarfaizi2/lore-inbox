Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbVJHNCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbVJHNCr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Oct 2005 09:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVJHNCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Oct 2005 09:02:47 -0400
Received: from host245-95.pool217223.interbusiness.it ([217.223.95.245]:53197
	"EHLO rc-vaio.rcdiostrouska.com") by vger.kernel.org with ESMTP
	id S932092AbVJHNCr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Oct 2005 09:02:47 -0400
Subject: Re: oops in 2.6.14-rc3
From: Sasa Ostrouska <sasa.ostrouska@volja.net>
Reply-To: sasa.ostrouska@volja.net
To: Grant Coady <grant_lkml@dodo.com.au>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <a49ek19jmmihflqguh7s2df2bvc6896f3n@4ax.com>
References: <1128731551.8004.2.camel@rc-vaio.rcdiostrouska.com>
	 <a49ek19jmmihflqguh7s2df2bvc6896f3n@4ax.com>
Content-Type: text/plain
Date: Sat, 08 Oct 2005 15:04:08 +0200
Message-Id: <1128776649.8149.5.camel@rc-vaio.rcdiostrouska.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-10-08 at 11:48 +1000, Grant Coady wrote:
> On Sat, 08 Oct 2005 02:32:31 +0200, Sasa Ostrouska <sasa.ostrouska@volja.net> wrote:
> 
> >Hi ppl, 
> >
> >	After some playing with my new slackware 10.2 and 
> >kernel 2.6.14-rc3 I noted this oops when shutting down the machine.
> >Can somebody tell me why ?
> >
> >Oct  8 02:20:33 rc-vaio kernel: Unable to handle kernel paging request
> >at virtual address f8c19706
> 
> What does 'grep swap /var/log/dmesg' have to say about it?
> 
> Grant.

Dear MR. Grant, many thanks for your answer. Here is what I have on 
dmesg:

root@rc-vaio:/home/sasa# grep swap /var/log/dmesg
Adding 1839376k swap on /dev/hda3.  Priority:-1 extents:1
across:1839376k
root@rc-vaio:/home/sasa#

Rgds
Sasa

