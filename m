Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424334AbWKJBet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424334AbWKJBet (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 20:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424336AbWKJBet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 20:34:49 -0500
Received: from koto.vergenet.net ([210.128.90.7]:25250 "EHLO koto.vergenet.net")
	by vger.kernel.org with ESMTP id S1424334AbWKJBet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 20:34:49 -0500
Date: Fri, 10 Nov 2006 10:27:33 +0900
From: Horms <horms@verge.net.au>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: yhlu <yinghailu@gmail.com>,
       Fastboot mailing list <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Kexec with latest kernel fail
Message-ID: <20061110012731.GH4107@verge.net.au>
References: <5986589C150B2F49A46483AC44C7BCA49071D2@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA49071D2@ssvlexmb2.amd.com>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 05:12:08PM -0800, Lu, Yinghai wrote:
> There is no configure in kexec-tools-testing

Sorry, you need to generate it from configure.ac by running autoconf

# autoconf && ./configure && make

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

