Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264021AbTICQVi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 12:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTICQUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 12:20:19 -0400
Received: from main.gmane.org ([80.91.224.249]:55002 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263896AbTICQTu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 12:19:50 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Blake B." <shadoi@nanovoid.com>
Subject: Re: 2.6.0-test 4 and USB
Date: Wed, 03 Sep 2003 08:27:18 -0600
Message-ID: <bj4to7$i3p$1@sea.gmane.org>
References: <3F5587A1.2020706@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
In-Reply-To: <3F5587A1.2020706@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

watermodem wrote:
> I forgot to note on the USB and CUPs problem that I see the USB tree 
> under "/sys/bus/usb" where-as under /proc/bus/usb I see nothing.
> This may break a lot of existing code... Is is suppose to be this way?
> 
> 
> 

Read /linux-kernel-source/Documentation/usb/proc_usb_info.txt

-b-


