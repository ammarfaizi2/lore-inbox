Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313242AbSDTXgL>; Sat, 20 Apr 2002 19:36:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313254AbSDTXgK>; Sat, 20 Apr 2002 19:36:10 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:5139 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S313242AbSDTXgJ>; Sat, 20 Apr 2002 19:36:09 -0400
Subject: Re: 2.4.19-pre7-ac1 breaks my USB mouse
From: Thomas Hood <jdthood@yahoo.co.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020420193508.GA18880@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 20 Apr 2002 19:38:14 -0400
Message-Id: <1019345897.834.2.camel@thanatos>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-20 at 15:35, Greg KH wrote:
> You don't have CONFIG_USB_HIDINPUT set, which you need to do.  You did
> read the help for it when doing 'make oldconfig', right?  :)
> Let me know if that fixes it for you.

That fixed it
-- Thanks.



_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

