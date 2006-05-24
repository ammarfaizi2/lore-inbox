Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932588AbWEXFF4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932588AbWEXFF4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 01:05:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932587AbWEXFF4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 01:05:56 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:47830 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932588AbWEXFFz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 01:05:55 -0400
Subject: Re: [Patch]Fix spanned_pages is not updated at a case of memory
	hot-add.
From: Dave Hansen <haveblue@us.ibm.com>
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060524100531.3468.Y-GOTO@jp.fujitsu.com>
References: <20060523170830.97E1.Y-GOTO@jp.fujitsu.com>
	 <1148401689.8658.12.camel@localhost.localdomain>
	 <20060524100531.3468.Y-GOTO@jp.fujitsu.com>
Content-Type: text/plain
Date: Tue, 23 May 2006 22:05:48 -0700
Message-Id: <1148447148.8658.34.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-24 at 10:18 +0900, Yasunori Goto wrote:
> Could you fix and repost it? Or should I? 

I'd appreciate it if you could test it, and forward it along
afterword.  

-- Dave

