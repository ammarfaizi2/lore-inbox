Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965898AbWKIFwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965898AbWKIFwG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 00:52:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965953AbWKIFwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 00:52:06 -0500
Received: from koto.vergenet.net ([210.128.90.7]:13202 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S965898AbWKIFwE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 00:52:04 -0500
Date: Thu, 9 Nov 2006 14:48:05 +0900
From: Horms <horms@verge.net.au>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: ebiederm@xmission.com, Fastboot mailing list <fastboot@lists.osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Kexec with latest kernel fail
Message-ID: <20061109054805.GA28415@verge.net.au>
References: <5986589C150B2F49A46483AC44C7BCA49071BF@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA49071BF@ssvlexmb2.amd.com>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2006 at 08:07:22PM -0800, Lu, Yinghai wrote:
> Eric,
> 
> I got "Invalid memory segment 0x100000 - ..."
> using kexec latest kernel...

Which kernel? What config? What architecture? What hardware?

> Do I need patch for kexec tools with latest kexec in kernel?

Its largely dependant on what architecture you are using.
But try out kexec-tools-testing if you are not already doing so.
It is available via git from www.kernel.org/git

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

