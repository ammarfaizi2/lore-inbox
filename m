Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270936AbUJUVPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270936AbUJUVPN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270803AbUJUVMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:12:24 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:52234 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S270928AbUJUVJw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:09:52 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Dave Hatton" <mail@davehatton.it>, <linux-kernel@vger.kernel.org>
Subject: Re: shutdown -h causes laptop to reboot since kernel 2.6.9
Date: Fri, 22 Oct 2004 00:09:45 +0300
User-Agent: KMail/1.5.4
References: <20041021200003.B515C252345@smtp.nildram.co.uk>
In-Reply-To: <20041021200003.B515C252345@smtp.nildram.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410220009.45137.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 21 October 2004 23:00, Dave Hatton wrote:
> Hi 
> 
> Since kernel 2.6.9, I'm finding "shutdown -g0 -h" now causes my HP nx7010
> laptop to reboot rather than power down. 
> 
> No problems prior to 2.9.0.

You mean 2.6.9.

You may try to find which 2.6.9-rcN was last working one.
--
vda

