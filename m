Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbTHUOzL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 10:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbTHUOzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 10:55:11 -0400
Received: from gate.corvil.net ([213.94.219.177]:9476 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S262691AbTHUOzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 10:55:08 -0400
Message-ID: <3F44DD03.4080002@draigBrady.com>
Date: Thu, 21 Aug 2003 15:53:55 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pankaj Garg <PGarg@MEGISTO.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Messaging between kernel modules and User Apps
References: <AD3C7008DB448D42ABA9346FE715E8340FFEF8@megisto-e2k.megisto.com>
In-Reply-To: <AD3C7008DB448D42ABA9346FE715E8340FFEF8@megisto-e2k.megisto.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pankaj Garg wrote:
> Hi,
> 
> I am writing a kernel module. The module will need to send asynchronous
> messages to a User Application. Is there a good and efficient way of
> doing this?

netlink socket?

Pádraig.

