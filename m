Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbTE2LKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 May 2003 07:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTE2LKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 May 2003 07:10:21 -0400
Received: from oak.sktc.net ([64.71.97.14]:45715 "EHLO oak.sktc.net")
	by vger.kernel.org with ESMTP id S262148AbTE2LKU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 May 2003 07:10:20 -0400
Message-ID: <3ED5EDB2.9060506@sktc.net>
Date: Thu, 29 May 2003 06:23:30 -0500
From: "David D. Hagood" <wowbagger@sktc.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Lowery <Robert.Lowery@colorbus.com.au>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: mounting VXDOS partitions under linux
References: <370747DEFD89D2119AFD00C0F017E66126C91D@cbus613-server4.colorbus.com.au>
In-Reply-To: <370747DEFD89D2119AFD00C0F017E66126C91D@cbus613-server4.colorbus.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One other thing to look out for is that Wind River also has a "long 
filename" FAT-like file system in which directory entries are longer, 
and which allows for longer filenames and case-sensitivity.

(Gads, I hate working with VxWorks. Wish I'd know a couple of years ago 
where Linux was going to be in a few months - I'd've never spec'ed my 
project to run under VxWorks.)

But yes, I would love to see a VxFAT module that could read WRS's 
wonderfully screwed up filesystems.

