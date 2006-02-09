Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422896AbWBIMTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422896AbWBIMTh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Feb 2006 07:19:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422898AbWBIMTg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Feb 2006 07:19:36 -0500
Received: from aeimail.aei.ca ([206.123.6.84]:30951 "EHLO aeimail.aei.ca")
	by vger.kernel.org with ESMTP id S1422896AbWBIMTg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Feb 2006 07:19:36 -0500
From: Ed Tomlinson <edt@aei.ca>
Organization: me
To: art@usfltd.com
Subject: Re: kernel-2.6.16-rc2-git4 --- reiserfs write problems !!!
Date: Thu, 9 Feb 2006 07:19:24 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <200602080024.AA52494644@usfltd.com>
In-Reply-To: <200602080024.AA52494644@usfltd.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602090719.26412.edt@aei.ca>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 01:24, art wrote:
> kernel-2.6.16-rc2-git4 --- reiserfs write problems
> 
> looks like with rc2 reiserfs have problem with writing - reading is ok
> 
> reiserfs is mounted on ext3 mount
> 
> with kernel-2.6.16-rc1-git6 works
> 
> any idea ???
> 
> xboom

Panic? with a return code 5?  If so you are not the only one.  See Thread:
Re: 2.6.16-rc1-mm2 (mm5 too) panics

Ed Tomlinson
