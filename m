Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269196AbUJQQp1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269196AbUJQQp1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 12:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269193AbUJQQp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 12:45:26 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:17167 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269205AbUJQQlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 12:41:21 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Sam Ravnborg <sam@ravnborg.org>, Albert Cahalan <albert@users.sf.net>
Subject: Re: Building on case-insensitive systems
Date: Sun, 17 Oct 2004 19:41:11 +0300
User-Agent: KMail/1.5.4
Cc: Dan Kegel <dank@kegel.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       sam@ravnborg.org
References: <1097989574.2674.14246.camel@cube> <1097991836.2666.14274.camel@cube> <20041017092730.GA9081@mars.ravnborg.org>
In-Reply-To: <20041017092730.GA9081@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410171941.11271.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 17 October 2004 12:27, Sam Ravnborg wrote:
> Try to estimate the cost associated with the shift:
> - Training
> - Less efficiency in a period
> - Missing important tools so a terminal service is needed
> - etc.
> 
> The valid solution here would be to deploy a Linux server.
> But then your arguments suffer compared to other OS'es where
> everything is running on the users current host - why have
> the hassle with a Linux server.

One Linux addict among employees should be enough to do it.

Typically, there are some old "slow" boxes lying around
which are not usable anymore with "improved" MS OSes due to
"insufficient" RAM/disk.
--
vda

