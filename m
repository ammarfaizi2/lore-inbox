Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262369AbTLMA3x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 19:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262598AbTLMA3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 19:29:52 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:60934 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S262369AbTLMA3v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 19:29:51 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Philippe Troin <phil@fifi.org>
Cc: "Jeremy Kusnetz" <JKusnetz@nrtc.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 is freezing my systems hard after 24-48 hours 
In-reply-to: Your message of "12 Dec 2003 13:26:12 -0800."
             <871xr9budn.fsf@ceramic.fifi.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 13 Dec 2003 11:29:40 +1100
Message-ID: <9678.1071275380@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Dec 2003 13:26:12 -0800, 
Philippe Troin <phil@fifi.org> wrote:
>You're not alone... I have the same problems: 2.4.22 works, 2.4.23
>locks up apparently randomly. I cannot get a backtrace with sysrq
>either.
>
>If only I could get a backtrace... :-)

Try serial console + kdb.  ftp://oss.sgi.com/projects/download/kdb/v4.3

