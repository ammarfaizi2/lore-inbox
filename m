Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbULYRrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbULYRrJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 12:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbULYRrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 12:47:09 -0500
Received: from web51503.mail.yahoo.com ([206.190.38.195]:9296 "HELO
	web51503.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261549AbULYRrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 12:47:04 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=4OFhK0toj7p0DvkAiMD1FHI5gTZOgJiIFIj+cdUPCJCdHJ89hWOUCiy2ZyXBfKa9wq3GZEz3GyCadX010d+HtCaDqoFS9Sr61nbPEcqOPW0Ty4FXXMPb+SvTDd22vzGNqnsuD1pZoV9q7YSOg+KyYMeoXI2ftiRa00DSyDqMi1c=  ;
Message-ID: <20041225174703.61222.qmail@web51503.mail.yahoo.com>
Date: Sat, 25 Dec 2004 09:47:03 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: [Ipsec] Issue on input process of Linux native IPsec
To: David Dillow <dave@thedillows.org>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
In-Reply-To: <1103922914.3016.13.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Dec 2004 at 16:15, David Dillow wrote:
> In the work I've been doing, I've found it very 
> helpful to open a text editor, and make a call 
> graph for the task I'm interested in -- in your
> case, a graph of every function that gets called 
> upon receive, starting with your network driver's 
> receive function.
>
> Doing a similar one for Tx would be useful for you 
> as well, though I'd start with the UDP output path, 
> as it was pretty simple.

I'll try it.
Thank you very much.


=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Dress up your holiday email, Hollywood style. Learn more. 
http://celebrity.mail.yahoo.com
