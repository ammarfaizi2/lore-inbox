Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbTKOXs2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Nov 2003 18:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262186AbTKOXs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Nov 2003 18:48:28 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20716 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262153AbTKOXs1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Nov 2003 18:48:27 -0500
Message-ID: <3FB6BB35.8090001@pobox.com>
Date: Sat, 15 Nov 2003 18:48:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] disallow modular BINFMT_ELF
References: <20031115232600.GF7919@fs.tum.de>
In-Reply-To: <20031115232600.GF7919@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> modular BINFMT_ELF gives unresolved symbols in 2.4 .
> 
> modular BINFMT_ELF gives the following unresolved symbols in 2.6:


Interesting.   this causes me to wonder if we should bother making 
BINFMT_ELF an option at all...

	Jeff



