Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750984AbWCYFJT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750984AbWCYFJT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 00:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWCYFJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 00:09:19 -0500
Received: from web8705.mail.in.yahoo.com ([203.84.221.126]:60862 "HELO
	web8705.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1750984AbWCYFJS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 00:09:18 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pVRJG+uQKZnoYfsmy+/AL0DJJbK7M3H6FExhyX8UMdpR3FjjRA4WXOLyfJQ3GZsXOOl60bHZSwAKsobDDYMzDFn/BPfAl+6AlMVhez9TIewUt9IlVD9N1c/l2Almqgw29K5l0fvrOj2IY10SZLGyU+B343hQQsSw2vEusyNTBFI=  ;
Message-ID: <20060325050910.25509.qmail@web8705.mail.in.yahoo.com>
Date: Sat, 25 Mar 2006 05:09:10 +0000 (GMT)
From: Amit Luniya <amit_31_08@yahoo.co.in>
Subject: Help related to socket creation in kernel space
To: Linux mailing <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello sir,
      I am final year student of comp. engg. from pune
university. My project is hibernation in network
environment. Existing utility of hibernation using
"swsusp.c" does not support ping operation or any
other n/w related services after resume. 
  Tell me whether could we create socket in code of
resume in such a way that we can get image back from
server? As ping is application layer program does not
support operation after resume , so could we do
creation of socket and write kernel level network
program in resume process and can communicate with
server?
 We are working on linux kernel 2.6.14.5 .
Please help us as we are hang over our project.
Have a good day sir.....


		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
