Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUDOVoM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Apr 2004 17:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262226AbUDOVoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Apr 2004 17:44:12 -0400
Received: from main.gmane.org ([80.91.224.249]:11676 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261728AbUDOVoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Apr 2004 17:44:09 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Martin Wilke <werwolf@unixfreunde.de>
Subject: Re: off:latest binary nvidia driver won't compile with 2.6.6-rc1
Date: Thu, 15 Apr 2004 23:44:48 +0200
Organization: unixfreunde.de
Message-ID: <pan.2004.04.15.21.44.46.572563@unixfreunde.de>
References: <1082061685.5837.2.camel@zeus.city.tvnet.hu> <20040415212923.GA2656@mars.ravnborg.org>
Reply-To: werwolf@unixfreunde.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd958c6e4.dip.t-dialin.net
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm i have problems too kernel 2.6.6.rc1 and nvidia
after modules Loading comming message invalid driver ...


Am Thu, 15 Apr 2004 23:29:23 +0200 schrieb Sam Ravnborg:

> On Thu, Apr 15, 2004 at 10:41:25PM +0200, Sipos Ferenc wrote:
>> Hi!
>> 
>> The outer module patch for .temp creation didn't solve the problem,
>> compilation stops with can't fine Modules.synver in /usr/src/linux-
>> 2.6.6-rc1.
> 
> You need to do a ' make modules' first, otherwise the Modules.symvers file
> will not be created.
> 
> 	Sam


