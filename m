Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263143AbUDAUQH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 15:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263147AbUDAUQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 15:16:07 -0500
Received: from opersys.com ([64.40.108.71]:54794 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S263143AbUDAUQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 15:16:05 -0500
Message-ID: <406C79E4.1060700@opersys.com>
Date: Thu, 01 Apr 2004 15:21:56 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: khandelw@cs.fsu.edu
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.4.16
References: <1080849830.91ac1e3f85274@system.cs.fsu.edu>
In-Reply-To: <1080849830.91ac1e3f85274@system.cs.fsu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Amit,

khandelw@cs.fsu.edu wrote:
>     I need linux2.4.16 because i want to use LTT and the documentation of LTT
> says that it can be used with that version. Can somebody gimme sm pointer
> realted to this.

You may want to try fixing this patch for the latest kernel (and I could
then host the updated patch on the project's site.) Or you may want to try
LTT 0.9.6pre3 with linux 2.6.3 and relayfs. This is the latest development
version. It's got rough edges, but it shouldn't be too hard to get working.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546

