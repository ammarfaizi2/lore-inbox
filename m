Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263595AbUBNXjT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 18:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263606AbUBNXjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 18:39:19 -0500
Received: from mail.wildpark.net ([193.220.59.132]:32420 "EHLO
	mail.wildpark.net") by vger.kernel.org with ESMTP id S263595AbUBNXjR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 18:39:17 -0500
Message-ID: <402EAC9E.7090300@hotbox.ru>
Date: Sun, 15 Feb 2004 01:17:50 +0200
From: Alexandr Chernyy <nikalex@hotbox.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, ru, uk
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 February 2004 22:05, Alexandr Chernyy wrote:

 >> Hello All! Can you help me! I write module for kernel 2.4.22 and have
 >> some problems! I need to read some information form file, create
 >> directory and etc. (Did kerlen have some stdio.h like function - fopen,
 >> fgets, fclose......)!!! Please help me.


 > what you are looking for is not usually needed by 'normal' kernel 
modules.
 > could you please be more specific on what is exactly your porpouse?

 > alessandro

for example i need to create directory in all mounting devices when 
module load!!!
and read some informations form /proc/mounts

WBR, Alexandr Chernyy


