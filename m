Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUAaRAO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 12:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264941AbUAaRAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 12:00:13 -0500
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:23990 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S264936AbUAaRAK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 12:00:10 -0500
Date: Sat, 31 Jan 2004 11:00:06 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: net-pf-10, 2.6.1
Message-ID: <20040131170006.GA24193@yggdrasil.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <E1AmU8a-00005E-00@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1AmU8a-00005E-00@localhost>
X-Operating-System: Linux yggdrasil 2.6.1 #1 SMP Sun Jan 25 13:00:36 CST 2004 i686 GNU/Linux
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 30, 2004 at 12:36:28AM -0800, root wrote:
> Is there any guidance about this little annoyance yet? Most of the
> advice I've seen (on other lists) suggests putting the following in
> modprobe.conf:
> 
>    install net-pf-10 /bin/true
> 
> But this has made no difference for me.

Did you run "update-modules" afterward?
