Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbUJWOrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbUJWOrL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 10:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbUJWOrK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 10:47:10 -0400
Received: from adsl-20-74.swiftdsl.com.au ([218.214.20.74]:13444 "EHLO
	gamma.soldator.com") by vger.kernel.org with ESMTP id S261207AbUJWOqf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 10:46:35 -0400
Message-ID: <417A6EC9.5000503@swiftdsl.com.au>
Date: Sun, 24 Oct 2004 00:46:33 +1000
From: Taso Hatzi <ahg2@swiftdsl.com.au>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.2) Gecko/20010726 Netscape6/6.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The naming wars continue...
References: <Pine.LNX.4.58.0410221431180.2101@ppc970.osdl.org> <20041023151819.GB2540@dantooine>
In-Reply-To: <20041023151819.GB2540@dantooine>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Oct 2004 03:40:06 +0200, Linus Torvalds wrote:

 >
 > However, for some reason four numbers just looks visually too obnoxious to
 > me, so as I don't care that much, I'll just use "-rc", and we can all

Drop the '2.'. What would make you go from 2 to 3 and realistically, is
it likely to happen?

In any case, if you replace the '-rc' suffix with just a number it will
be interpreted as 2.x.y.1 is better than 2.x.y which is a nonsense.
The "-rc" nomenclature makes it clear that the release will be 2.x.y

