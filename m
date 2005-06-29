Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVF2Kw5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVF2Kw5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 06:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbVF2Kw4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 06:52:56 -0400
Received: from gate.corvil.net ([213.94.219.177]:39175 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S262527AbVF2Kw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 06:52:28 -0400
Message-ID: <42C27D62.1040201@draigBrady.com>
Date: Wed, 29 Jun 2005 11:52:18 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: accessing loopback filesystem+partitions on a file
References: <20050628233335.GB9087@lkcl.net>
In-Reply-To: <20050628233335.GB9087@lkcl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luke Kenneth Casson Leighton wrote:
> 
> 	* how the hell do you loopback mount (or lvm mount
> 	  or _anything_! something!)  partitions that have
> 	  been created in a loopback'd file!!!!

Have a look at http://www.pixelbeat.org/scripts/lomount.sh

Pádraig.
