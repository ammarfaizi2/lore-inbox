Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287798AbSA3BMo>; Tue, 29 Jan 2002 20:12:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287816AbSA3BMe>; Tue, 29 Jan 2002 20:12:34 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:54797 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S287798AbSA3BMX>; Tue, 29 Jan 2002 20:12:23 -0500
Subject: Re: 2.4.18-pre7 slow ... apm problem
From: Thomas Hood <jdthood@yahoo.co.uk>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <Pine.LNX.4.44.0201292029410.892-100000@boston.corp.fedex.com>
In-Reply-To: <Pine.LNX.4.44.0201292029410.892-100000@boston.corp.fedex.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 29 Jan 2002 20:12:29 -0500
Message-Id: <1012353152.4807.146.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-29 at 07:36, Jeff Chua wrote:
> Ok got it. But still have to reboot machine as the apm is loaded and can't
> "rmmod apm". Complained that it's in use ([kapmd] even after stopping
> apmd.

That's a bug, I think.  You should be able to rmmod the apm module.




_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

